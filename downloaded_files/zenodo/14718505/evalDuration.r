# Compares the efficiency in terms of duration between both treatments T_S and T_NS
# Treatment T_S:  with suggestions
# Treatment T_NS: without suggestions

library(readr)
library(ggpubr) # install.packages("ggpubr") for ggqqplot
library(coin) # install.packages("coin") for wilcoxsign_test

df <- read_csv("ProbandData.csv")

# Whether subjects without Java experience should be dropped.
drop.non.java = FALSE
if (drop.non.java) {
  # Drop all subjects without Java experience.
  df = df[!(df$`Ich habe Erfahrungen mit Java-Entwicklung.` %in% "Nein"),]  
}

drop.14 = TRUE
if (drop.14) {
  # Subject 14 will be excluded because he was tired and because his session
  # was affected by too many bugs
  df <- df[-c(14), ]
}

# Gruppe A: started with task T_S
# Gruppe B: started with task T_NS

# see_task1_start_update relates to task T_S with suggestions, if subject belongs to group A
# see_task1_start_update relates to task T_NS without suggestions, if subject belongs to group B

# see_task2_start_update relates to task T_S with suggestions, if subject belongs to group A
# see_task2_start_update relates to task T_NS without suggestions, if subject belongs to group B

# and so forth for the other time columns

df$T_S_duration = ifelse(df$Gruppe=="A", 
                         df$see_task1_done_update - df$see_task1_start_update, 
                         df$see_task2_done_update - df$see_task2_start_update)

df$T_NS_duration = ifelse(df$Gruppe=="B", 
                         df$see_task1_done_update - df$see_task1_start_update, 
                         df$see_task2_done_update - df$see_task2_start_update)

in.minutes.and.seconds = function(minutes) {
    mins = floor(minutes)
    secs = round((minutes - mins)*60, 0)
    paste(as.character(mins), " [min] ", as.character(secs), " [sec]", sep="")
}

print.statistics = function(aspect, data) {
  cat(aspect, "median=", in.minutes.and.seconds(median(data)), 
      "mean=", in.minutes.and.seconds(mean(data)), 
      "sd=", in.minutes.and.seconds(sd(data)), "\n")
}

print.statistics("Duration T_S:",  df$T_S_duration)
print.statistics("Duration T_NS:", df$T_NS_duration)

# Alternative hypothesis: df$T_S_duration < df$T_NS_duration

# Visual test for normal distribution.
duration = c(df$T_S_duration, df$T_NS_duration)
ggqqplot(duration)

# Shapiro-Wilk test for normal distribution (null hypothesis: data has normality).
# p value > alpha implies that the distribution of the data are not significantly 
# different from normal distribution. In other words, we can assume the normality.
# Note that, normality test is sensitive to sample size. Small samples most often 
# pass normality tests. Therefore, it’s important to combine visual inspection 
# and significance test in order to take the right decision. 
shapiro = shapiro.test(duration)
shapiro
if (shapiro$p > 0.05) {
  print("normal distribution for duration may be assumed; t-test may be used")
} else {
  print("normal distribution for duration must not be assumed; t-test must not be used")
}

# t test
t.test(df$T_S_duration, df$T_NS_duration, alternative="less", paired=TRUE) 

# Wilcoxon Signed-Rank Test
wilcox.test(df$T_S_duration, df$T_NS_duration, alternative="less", paired=TRUE)

# In Wilcoxon's Signed-Rank Test, a tie occurs when the difference between a pair 
# of observations is zero. This means that the two values being compared are equal, 
# resulting in no difference to rank. Ties are typically excluded from the 
# ranking process because they do not contribute to the test statistic.
#
# In the Mann-Whitney U Test, a tie occurs when two or more values in the 
# combined data set are equal. This can happen when the values being compared 
# from the two independent samples are the same. Ties are handled by assigning 
# the average of the ranks that would have been assigned to the tied values if 
# they were different.
#
# Look at ties and zeros:
sort(df$T_S_duration - df$T_NS_duration)

# Too many ties? 
# For wilcoxsign_test, the default method of handling zeros (zero.method = "Pratt"), 
# due to Pratt (1959), first rank-transforms the absolute differences 
# (including zeros) and then discards the ranks corresponding to the 
# zero-differences. The proposal by Wilcoxon (1949, p. 6) first discards 
# the zero-differences and then rank-transforms the remaining absolute 
# differences (zero.method ="Wilcoxon").
#
# Starting with coin version 1.0-16, the zero.method argument replaced the 
# (now removed) ties.method argument. The current default is zero.method = "Pratt" 
# whereas earlier versions had ties.method= "HollanderWolfe", which is 
# equivalent to zero.method = "Wilcoxon".
wilcoxsign_test(df$T_S_duration ~ df$T_NS_duration, distribution = "exact", 
                alternative="less", paired=TRUE, zero.method="Pratt")
wilcoxsign_test(df$T_S_duration ~ df$T_NS_duration, distribution = "exact", 
                alternative="less", paired=TRUE, zero.method="Wilcoxon")
