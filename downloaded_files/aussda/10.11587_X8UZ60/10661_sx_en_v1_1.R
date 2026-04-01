library(tidyverse)
library(broom)
library(rio)
library(stargazer)

## setup output/ dir ------------------------------

dir.create("../output/statistics", recursive = TRUE)
dir.create("../output/figures", recursive = TRUE)
dir.create("../output/tables", recursive = TRUE)

## read in merged data Jennings-Wlezien and V-Dem 
## 10661_da_en_v1_1.csv ---------------------------

polls <- import("../data/10661_da_en_v1_1.csv")

## write number of years and number of countries. Note that this will
## differ in different analyses since some of the IVs will be missing:

length(unique(polls$countryid)) %>%
  formatC(format = "d", big.mark = ",") %>%
  writeLines("../output/statistics/n-countries.tex")

length(unique(polls$year)) %>%
  formatC(format = "d", big.mark = ",") %>%
  writeLines("../output/statistics/n-years.tex")

## DV - avgerror, error between poll preds and actual vote on election day:
## Stata:
## gen error1 = abs(ipoll_1- vote_1)
## gen error2 = abs(ipoll_2- vote_2)
## gen error3 = abs(ipoll_3- vote_3)

## gen avgerror = (error1 + error2)/2

## IV's:

## v2eltrnout = what % of registered voters cast a ballot
## polls <- polls %>%
##   mutate(turnout = v2eltrnout)

## votedelta - change in party vote share from one election to the other:
## Stata:
## gen votedelta1 = abs(vote_1- lvote_1)
## gen votedelta2 = abs(vote_2- lvote_2)
## gen votedelta = (votedelta1 + votedelta2)/2

polls <- polls %>%
  mutate(electoral_change = votedelta)


## v2elvotbuy - vote buying, low = hi vote buy, hi = low vote buy
## Flip vote buying so that lower numbers mean less vote buying and higher numbers mean more:

polls <- polls %>%
  mutate(votes_bought = v2elvotbuy * -1)

## Jennings-Wlezien show that election type (legislative/prez) can affect poll
## accuracy, we'll want to control for that:
polls <- polls %>%
  mutate(presidential = election == "Presidential")

## Create variables: lagged dependent, changes, etc:
polls <- polls %>%
  arrange(countryid, year) %>%
  group_by(countryid) %>%
  mutate(ldelta = lag(electoral_change),
         cturnout = turnout - lag(turnout),
         abs_cturnout = abs(cturnout),
         cresults_change = electoral_change - lag(electoral_change),
         cvotes_bought = votes_bought - lag(votes_bought)) %>%
  ungroup

## ANALYSIS  ------------------------------

means_by_year <- polls %>%
  group_by(year) %>%
  arrange(countryid, year) %>%
  select(year, avgerror, turnout, electoral_change, votes_bought) %>%
  summarize_if(is.numeric, funs(mean(., na.rm = TRUE))) %>%
  gather(var, val, -year)

polls %>%
  group_by(countryid) %>%
  arrange(countryid, year) %>%
  select(countryid, year, avgerror, turnout, electoral_change, votes_bought) %>%
  gather(var, val, -countryid, -year) %>%
  ggplot(aes(year, val,
             color = factor(countryid))) +
  facet_wrap( ~ var,
             scale = "free",
             labeller = as_labeller(c(avgerror = "Average error",
                                      electoral_change = "Electoral change",
                                      turnout = "Turnout",
                                      votes_bought = "Vote buying"))) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3) +
  geom_smooth(aes(year, val), color = "black",
              se = FALSE, inherit.aes = FALSE) +
  geom_rug(sides = "l", color = "grey", alpha = 0.2) +
  scale_color_discrete(guide = FALSE) +
  labs(x = "",
       y = "") +
  theme_bw()

ggsave("../output/figures/variables.pdf",
       height = 6.5,
       width = 9)

## What does a regression with just year or just country fixed effects
## look like?
anv_models <- list(years = avgerror ~ factor(year),
                  countries = avgerror ~ factor(countryid),
                  both = avgerror ~ factor(year) + factor(countryid))

## Extract R^2 statistics and save them:
anv_r_sqr <- map(anv_models, ~ lm(.x, data = polls)) %>%
  map(summary) %>%
  map_dbl("r.squared")

## to get % variance explained, multiply R^2 by 100 then round to 1
## decimal:
var_explained <- as.character(round(anv_r_sqr * 100, 1))

var_explained[1] %>%
  writeLines("../output/statistics/var-explained-years.tex")
var_explained[2] %>%
  writeLines("../output/statistics/var-explained-countries.tex")
var_explained[3] %>%
  writeLines("../output/statistics/var-explained-both.tex")

### LEVELS ------------------------------
## Create table of descriptive statistics of DV and IVs:

polls %>%
  select(avgerror, turnout, electoral_change, votes_bought) %>%
  data.frame %>%
  stargazer(out = "../output/tables/descriptive.tex",
            covariate.labels = c("Polling error",
                                 "Voter turnout",
                                 "Electoral change", "Vote buying"),
            digits = 2,
            float = FALSE)

median(polls$avgerror, na.rm = TRUE) %>%
  round(2) %>%
  as.character %>%
  writeLines("../output/statistics/dv-median.tex")
mean(polls$avgerror, na.rm = TRUE) %>%
  round(2) %>%
  as.character %>%
  writeLines("../output/statistics/dv-mean.tex")

## Create object holding list of formulae
formulae <- list(
  turnout = avgerror ~ turnout,
  electoral_change = avgerror ~ electoral_change,
  votes_bought = avgerror ~ votes_bought,
  all = avgerror ~ turnout + electoral_change + votes_bought
)

## Regress the above formulae
regs <- map(formulae, ~ lm(.x, data = polls))

map(regs, tidy)
map(regs, glance)

## Add country fixed-effects:
## some countries only have one observation:
countryid_one_obs <- data.frame((one_obs = table(polls$countryid) == 1)) %>%
  rownames_to_column %>%
  filter(one_obs) %>%
  select(rowname) %>%
  .$rowname %>%
  as.numeric

regs_with_country <- map(formulae, ~ update(.x, . ~ . + factor(countryid))) %>%
  map( ~ lm(.x, data = filter(polls, !countryid %in% countryid_one_obs)))

map(regs_with_country, tidy) %>%
  map(head)

map(regs_with_country, glance)

stargazer(regs_with_country,
          covariate.labels = c("Voter turnout",
                               "Electoral change", "Vote buying"),
          keep = c("turnout", "electoral_change", "votes_bought"),
          notes = "Includes country fixed effects",
          dep.var.caption = "Average Polling Error",
          dep.var.labels.include = FALSE,
          float = FALSE,
          omit.stat = c("f", "ser"),
          out = "../output/tables/regression-country-fixed-effects.tex")


## Create a table of results including country fixed effects:
table_regs <- regs
table_regs[[5]] <- regs_with_country[[4]]

stargazer(table_regs,
          covariate.labels = c("Voter turnout",
                               "Electoral change", "Vote buying"),
          column.labels = c("Model 1", "Model 2", "Model 3",
                            "Model 4", "Model 5"),
          keep = c("turnout", "electoral_change", "votes_bought"),
          add.lines = list(c("Country FE", "No", "No",
                             "No", "No", "Yes")),
          model.numbers = FALSE,
          dep.var.caption = "Average Polling Error",
          dep.var.labels.include = FALSE, float = FALSE,
          omit.stat = c("f", "ser"),
          out = "../output/tables/regression.tex")

## Write out beta-hat values for reporting in-text:
map(regs, tidy) %>%
  map( ~ filter(., term != "(Intercept)")) %>%
  map("estimate") %>%
  map( ~ round(., 2)) %>%
  as.character %>%
  map2(names(formulae), ~ writeLines(.x, paste0("../output/statistics/beta-", .y, ".tex")))

## Write out the r-squared values for reporting in-text:
map(regs, glance) %>%
  map("r.squared") %>%
  map( ~ . * 100) %>%
  map( ~ round(., 1)) %>%
  as.character %>%
  map2(names(formulae), ~ writeLines(.x, paste0("../output/statistics/r-squared-", .y, ".tex")))
## Overwrite the rsquared value with adj rsqu for the model containing
## more than one coef:

(glance(regs[[4]])$adj.r.squared * 100) %>%
  round(1) %>%
  as.character %>%
  writeLines("../output/statistics/r-squared-all.tex")

## Look at effect sizes
sds <- polls %>%
      select(turnout, electoral_change, votes_bought) %>%
  summarize_all(funs(sd(., na.rm = TRUE)))

change_sds <- map(sds, ~ c(0, .x))

## For each var individually:
my_uncontrolled_effects <- vector("list", length(regs) - 1)
for (i in 1:(length(regs) - 1)) {
  std_change <- sds
  std_change[, -i] <- 0
  std_change[2, ] <- 0
  ## ## have to pick a factor that actually exists
  ## std_change$countryid <- as.factor(2)
  names(my_uncontrolled_effects)[i] <- names(regs[i])
  effect <- data.frame(predict(regs[[i]],
                              newdata = std_change,
                              interval = "confidence"))
  effect <- effect[1, ] - effect[2, ]
  effect$var <- names(regs[i])
  effect$type <- "uncontrolled"
  my_uncontrolled_effects[[i]] <- effect
}

## Controlling for the others:
my_controlled_effects <- vector("list", length(regs_with_country) - 1)
for (i in 1:3){
  std_change <- sds
  std_change[, -i] <- 0
  std_change[2, ] <- 0
  ## have to pick a factor that actually exists
  std_change$countryid <- as.factor(2)
  names(my_controlled_effects)[i] <- names(regs_with_country[i])
  effect <- data.frame(predict(regs_with_country[[4]],
                              newdata = std_change,
                              interval = "confidence"))
  effect <- effect[1, ] - effect[2, ]
  effect$var <- names(regs_with_country[i])
  effect$type <- "controlled"
  my_controlled_effects[[i]] <- effect
}

rbind(do.call("rbind", my_controlled_effects),
      do.call("rbind", my_uncontrolled_effects)) %>%
  mutate(var = factor(var, labels = c("Electoral change",
                                      "Voter turnout",
                                      "Vote buying")),
         type = factor(type, levels = c("uncontrolled", "controlled"))) %>%
  ggplot(aes(var, fit,
             ymin = lwr,
             ymax = upr,
             fill = var)) +
  facet_grid(. ~ type,
             labeller = as_labeller(c(uncontrolled = "Bivariate results (Models 1-3)",
                                      controlled = "Multiple regression results (Model 4)"))) +
  geom_col(position = "dodge") +
  geom_errorbar(position = "dodge",
                linetype = "dashed",
                width = 0.7) +
  geom_hline(yintercept = 0) +
  scale_fill_discrete(guide = FALSE) +
  labs(x = "",
       y = "Predicted change in polling error\nfrom a one standard deviation change") +
  theme_bw()

ggsave("../output/figures/effect-sizes.pdf",
       height = 6.5,
       width = 9)

## Rerun analysis, controlling for legislative versus presidential elections, as
## Jennings-Wlezien find a difference in poll accuracy:

regs_with_prez <- map(formulae, ~ update(.x, . ~ . + presidential)) %>%
  map( ~ lm(.x, data = polls))

stargazer(regs_with_prez,
          covariate.labels = c("Voter turnout", "Electoral change",
                               "Vote buying", "Presidential"),
          notes = "Rerun of main models, controlling for legislative or presidential elections",
          dep.var.caption = "Average Polling Error",
          dep.var.labels.include = FALSE,
          float = FALSE,
          omit.stat = c("f", "ser"),
          out = "../output/tables/regression-leg-prez.tex")

## Add year fixed-effects:
## Some years only have one observation

year_one_obs <- data.frame((one_obs = table(polls$year) == 1)) %>%
  rownames_to_column %>%
  filter(one_obs) %>%
  select(rowname) %>%
  .$rowname %>%
  as.numeric

regs_with_year <- map(formulae, ~ update(.x, . ~ . + factor(year))) %>%
  map( ~ lm(.x, data = filter(polls, !year %in% year_one_obs)))

map(regs_with_year, tidy) %>%
  map(head)

map(regs_with_year, glance)

stargazer(regs_with_year,
          covariate.labels = c("Voter turnout",
                               "Electoral change", "Vote buying"),
          keep = c("turnout", "electoral_change", "votes_bought"),
          notes = "Includes year fixed effects",
          dep.var.caption = "Average Polling Error",
          dep.var.labels.include = FALSE,
          float = FALSE,
          omit.stat = c("f", "ser"),
          out = "../output/tables/regression-year-fixed-effects.tex")




### CHANGES ------------------------------

## Look at changes rather than levels:
cformulae <- list(
  turnout = avgerror ~ cturnout,
  results_change = avgerror ~ cresults_change,
  votes_bought = avgerror ~ cvotes_bought,
  all = avgerror ~ cturnout + cresults_change + cvotes_bought
)

## Regress the above formulae
map(cformulae, ~ lm(.x, data = polls)) %>%
  map(tidy)

## Add year fixed-effects:
map(cformulae, ~ update(.x, . ~ . + factor(year))) %>%
  map( ~ lm(.x, data = polls)) %>%
  map(tidy) %>%
  map(head)

## Add country fixed-effects:
map(cformulae, ~ update(.x, . ~ . + factor(countryid))) %>%
  map( ~ lm(.x, data = polls)) %>%
  map(tidy) %>%
  map(head)
