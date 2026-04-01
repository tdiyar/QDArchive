####
# Install and load required packages ----
####

# install pacman (if it is not already installed), a package management tool for
## installing and loading packages (see https://cran.r-project.org/web/packages/pacman/index.html)
if (!require("pacman")) install.packages("pacman")

# loading all require packages for this script
pacman::p_load(here,      # enables easy file referencing by using the top-level directory of a file 
               ## (see https://cran.r-project.org/web/packages/here/vignettes/here.html)
               tidyverse, # collection of packages for data science (e.g., ggplot, dplyr, readr, etc.)
               ## (see https://www.tidyverse.org/)
               readtext,  # import of plain text files
               lubridate  # handling date-time data
)


####
# Setting working directory with here ----
####

require(here)
here::i_am("10817_sx02_en_v1_0.R")


####
# Unzipping the dataset ----
####

unzip(here("10817_da01_en_v1_0.zip"), exdir = here())


####
# Data import ----
####

df <- readtext(here("data", "*.txt"), docvarsfrom = "filenames", 
               docvarnames = c("event", "year", "committee", "actor", "month", "day", "count_statement"),
               dvsep = "_",
               encoding = "UTF8")


####
# Data transformation ----
####

# gather year, month and day into a new column "date"
df$date <- as.Date(with(df, paste(year, month, day,sep = "-")), "%Y-%m-%d")

# create new variable "quarter"
df$quarter <- as.factor(quarter(df$date))

# unzip list of actors
unzip(here("10817_om_en_v1_0.zip"), exdir = here())

# import list of actors
list_states <- readLines("list_states.txt")
list_igos <- readLines("list_igos.txt")
list_groups <- readLines("list_state-groups.txt")
list_ngos <- readLines("list_ngos.txt")
list_others <- readLines("list_others.txt")

# add actors to dataframe
df <- df %>% 
  mutate(type = case_when(actor %in% list_states ~ "State",
                          actor %in% list_igos ~ "IGO",
                          actor %in% list_groups ~ "Group",
                          actor %in% list_ngos ~ "NGO",
                          actor %in% list_others ~ "Other")
  )

df <- df %>% mutate_at(c("event", "committee", "actor", "type"), as.factor)


####
# save dataframe ----
####

# save as .csv (with ";" as seperator)
write_csv2(df, "10817_da01_en_v1_0.csv")
