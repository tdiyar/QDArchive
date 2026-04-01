# Compares the TXL values between both treatments T_S and T_NS
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

# Original Raw-TLX calculation: 
# Each question is answered on an ordinal scale with 21 gradations from
# "very low" to "very high". Scale ratings are scored based on where the user 
# marked the scale. Tick marks range from 0 to 100 by 5 point increments. Lower 
# values are better. The values for the six different aspects are combined into
# a single value as weighted average of the aspects for NASA-TLX. In case of
# Raw-TLX, the weights are all 1. That is, Raw-TXL uses the average over all
# aspects.
# 
# The respondents of our TLX questionnaire were given a 10-point scale instead
# of the 21-point scale, where the lowest value was 1 and the highest was 10.
# That means, we need to transform our input to conform to Raw-TLX.
to.tlx = function(index) {
  (index - 1) * (100 / 9)
}

# Gruppe A: started with task T_S
# Gruppe B: started with task T_NS

# tlx_1_1 relates to task T_S with suggestions, if subject belongs to group A
# tlx_1_1 relates to task T_NS without suggestions, if subject belongs to group B

# tlx_1_2 relates to task T_S with suggestions, if subject belongs to group A
# tlx_1_2 relates to task T_NS without suggestions, if subject belongs to group B
# and so forth

# tlx_*_1 ist Mental Demand
# tlx_*_2 ist Physical Demand
# tlx_*_3 ist Temporal Demand
# tlx_*_4 ist Performance
# tlx_*_5 ist Effort
# tlx_*_6 ist Frustration

# TLX subscales for Task T_S
# T_S_TLX_mental = tlx_1_1 if subject belongs to group A, tlx_2_1 otherwise
# T_S_TLX_physical = tlx_1_2 if subject belongs to group A, tlx_2_2 otherwise
# and so forth

df$T_S_TLX_mental       = to.tlx(ifelse(df$Gruppe=="A", df$tlx_1_1, df$tlx_2_1))
df$T_NS_TLX_mental      = to.tlx(ifelse(df$Gruppe=="B", df$tlx_1_1, df$tlx_2_1))

df$T_S_TLX_physical     = to.tlx(ifelse(df$Gruppe=="A", df$tlx_1_2, df$tlx_2_2))
df$T_NS_TLX_physical    = to.tlx(ifelse(df$Gruppe=="B", df$tlx_1_2, df$tlx_2_2))

df$T_S_TLX_temporal     = to.tlx(ifelse(df$Gruppe=="A", df$tlx_1_3, df$tlx_2_3))
df$T_NS_TLX_temporal    = to.tlx(ifelse(df$Gruppe=="B", df$tlx_1_3, df$tlx_2_3))

df$T_S_TLX_performance  = to.tlx(ifelse(df$Gruppe=="A", df$tlx_1_4, df$tlx_2_4))
df$T_NS_TLX_performance = to.tlx(ifelse(df$Gruppe=="B", df$tlx_1_4, df$tlx_2_4))

df$T_S_TLX_effort       = to.tlx(ifelse(df$Gruppe=="A", df$tlx_1_5, df$tlx_2_5))
df$T_NS_TLX_effort      = to.tlx(ifelse(df$Gruppe=="B", df$tlx_1_5, df$tlx_2_5))

df$T_S_TLX_frustration  = to.tlx(ifelse(df$Gruppe=="A", df$tlx_1_6, df$tlx_2_6))
df$T_NS_TLX_frustration = to.tlx(ifelse(df$Gruppe=="B", df$tlx_1_6, df$tlx_2_6))

# The original TLX value range for TLX is [0, 100].
print.statistics = function(aspect, data) {
  cat(aspect, "median=", median(data), 
      "mean=", round(mean(data), 2), 
      "sd=", round(sd(data), 2), "\n")
}

print.statistics("TLX Mental Demand T_S:", df$T_S_TLX_mental)
print.statistics("TLX Mental Demand T_NS:", df$T_NS_TLX_mental)

print.statistics("TLX Physical Demand T_S:", df$T_S_TLX_physical)
print.statistics("TLX Physical Demand T_NS:", df$T_NS_TLX_physical)

print.statistics("TLX Temporal Demand T_S:", df$T_S_TLX_temporal)
print.statistics("TLX Temporal Demand T_NS:", df$T_NS_TLX_temporal)

print.statistics("TLX Performance T_S:", df$T_S_TLX_performance)
print.statistics("TLX Performance T_NS:", df$T_NS_TLX_performance)

print.statistics("TLX Effort T_S:", df$T_S_TLX_effort)
print.statistics("TLX Effort T_NS:", df$T_NS_TLX_effort)

print.statistics("TLX Frustration T_S:", df$T_S_TLX_frustration)
print.statistics("TLX Frustration T_NS:", df$T_NS_TLX_frustration)

# Total Raw-TLX is the average over all individual aspects
df$T_S_TLX_total_raw = (df$T_S_TLX_mental + df$T_S_TLX_physical + df$T_S_TLX_temporal +
  df$T_S_TLX_performance + df$T_S_TLX_effort + df$T_S_TLX_frustration) /6

df$T_NS_TLX_total_raw = (df$T_NS_TLX_mental + df$T_NS_TLX_physical + df$T_NS_TLX_temporal +
 df$T_NS_TLX_performance + df$T_NS_TLX_effort + df$T_NS_TLX_frustration) / 6

print.statistics("TLX Total Raw T_S:",  df$T_S_TLX_total_raw)
print.statistics("TLX Total Raw T_NS:", df$T_NS_TLX_total_raw)

# Lower TLX is better.
# Alternative hypothesis: df$T_S_TLX_total_raw < df$T_NS_TLX_total_raw

# Visual test for normal distribution.
TLX_total_raw = c(df$T_S_TLX_total_raw, df$T_NS_TLX_total_raw)
ggqqplot(TLX_total_raw)

# Shapiro-Wilk test for normal distribution (null hypothesis: data has normality).
# p value > alpha implies that the distribution of the data are not significantly 
# different from normal distribution. In other words, we can assume the normality.
# Note that, normality test is sensitive to sample size. Small samples most often 
# pass normality tests. Therefore, it’s important to combine visual inspection 
# and significance test in order to take the right decision. 
shapiro = shapiro.test(TLX_total_raw)
shapiro
if (shapiro$p > 0.05) {
  print("normal distribution for Raw-TLX may be assumed; t-test may be used")
} else {
  print("normal distribution for Raw-TLX must not be assumed; t-test must not be used")
}

# t test
t.test(df$T_S_TLX_total_raw, df$T_NS_TLX_total_raw, alternative="less", paired=TRUE) 

# Wilcoxon Signed-Rank Test
wilcox.test(df$T_S_TLX_total_raw, df$T_NS_TLX_total_raw, alternative="less", paired=TRUE)

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
sort(df$T_S_TLX_total_raw - df$T_NS_TLX_total_raw)

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
wilcoxsign_test(df$T_S_TLX_total_raw ~ df$T_NS_TLX_total_raw, distribution = "exact", 
                alternative="less", paired=TRUE, zero.method="Pratt")
wilcoxsign_test(df$T_S_TLX_total_raw ~ df$T_NS_TLX_total_raw, distribution = "exact", 
                alternative="less", paired=TRUE, zero.method="Wilcoxon")

# wilcoxsign_test with "Pratt" or "Wilcoxon" handle only zeros but not
# ties in the sense of the Mann-Whitney U Test (two or more values in the
# combined data set are equal).
#
# The standard solution for equal values in the Mann-Withney U-Test is the midrank
# approach. A midrank is the average rank assigned to tied observations in a
# data set. When two or more values are tied, instead of assigning them the same
# rank, you calculate the average of the ranks they would have occupied if they
# were different.

# If there are many ties (more than 15%), it's better to use Fisher-Pitman's
# permutation test if the samples are independent (non-paired). This can be done 
# as described here:
# https://mac-theobio.github.io/QMEE/lectures/permutation_examples.notes.html
#
# An example can be found in our own R script for a paper we published at 
# VISSOFT 2022: 
# https://github.com/uni-bremen-agst/VISSOFT2022/blob/main/calc_results.R#L202):
#  DV <- c(getfirst(a4cp$p), getsecond(a4cp$p))
#  IV <- factor(rep(c("A", "B"), c(10, 10)))
#  oneway_test(DV ~ IV, alternative="less", exact=T)

# Yet, our samples are not independent because we have a data point for both
# samples from the same subject. That is why we need to use blocking for 
# stratification.
# 
# We are facing the following task:
# - one factor "suggestions" with two levels: "with" and "without"
# - one numeric variable "Total Raw-TLX"
# - one factor identifying the subject with n levels where n is the number of subjects
#
# We want to test whether there is a difference for "Total Raw-TLX" between
# "with" and "without" suggestions, where we need to make a paired comparison
# for each subject.
#

df$subject = seq.int(nrow(df))

# First, we will create a data frame df.tlx with three columns:
# subject: the index of the subject the paired data points came from;
#          there will be two rows in df.tlx for each subject as we have
#          two samples; the index will be a factor
# suggestions: whether suggestions were available to obtain the total Raw-TLX;
#              either "with" or "without" as a factor
# total_raw_tlx: the total Raw-TLX; this is T_S_TLX_total_raw if suggestions
#                were available; otherwise T_NS_TLX_total_raw

# Empty table with three columns
df.tlx = setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("subject", "total_raw_tlx", "suggestions"))

add.to.df.tlx = function(row) {
  # Note that df.tlx is a global variable, hence, we need the assignment <<-
  df.tlx[nrow(df.tlx) + 1,] <<- c(row$subject, as.numeric(row$T_S_TLX_total_raw), "with")
  df.tlx[nrow(df.tlx) + 1,] <<- c(row$subject, as.numeric(row$T_NS_TLX_total_raw), "without")
}

# Iterate over all rows in df and run add.to.df.tlx on each.
by(df, seq_len(nrow(df)), add.to.df.tlx)

df.tlx$subject = as.factor(df.tlx$subject)
df.tlx$suggestions = as.factor(df.tlx$suggestions)
df.tlx$total_raw_tlx = as.numeric(df.tlx$total_raw_tlx)

# Asymptotic Two-Sample Fisher-Pitman Permutation Test
# Note: The exact test (parameter distribution="exact") could not be used 
# because of ties.
oneway_test(total_raw_tlx ~ suggestions | subject, data=df.tlx, 
            alternative="less")

# Exact General Symmetry Test
symmetry_test(total_raw_tlx ~ suggestions | subject, data=df.tlx, 
              alternative="less", distribution="exact")


