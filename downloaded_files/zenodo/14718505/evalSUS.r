# Calculates SUS.

library(readr)

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

print.statistics = function(aspect, data) {
  cat(aspect, "median=", median(data), "mean=", round(mean(data), 2), "sd=", round(sd(data), 2), "\n")
}

sus.weight = function(data, positive=TRUE) {
  if (positive) {
    return((data - 1) * 2.5)
  }
  else {
    return ((5 - data) * 2.5)
  }
}

# questions with odd number are positively worded,
# questions with even number are negatively worded,

df$SUS.w1  = sus.weight(df$sus1, positive=TRUE)
df$SUS.w2  = sus.weight(df$sus2, positive=FALSE)
df$SUS.w3  = sus.weight(df$sus3, positive=TRUE)
df$SUS.w4  = sus.weight(df$sus4, positive=FALSE)
df$SUS.w5  = sus.weight(df$sus5, positive=TRUE)
df$SUS.w6  = sus.weight(df$sus6, positive=FALSE)
df$SUS.w7  = sus.weight(df$sus7, positive=TRUE)
df$SUS.w8  = sus.weight(df$sus8, positive=FALSE)
df$SUS.w9  = sus.weight(df$sus9, positive=TRUE)
df$SUS.w10 = sus.weight(df$sus10, positive=FALSE)

df$SUS.total = df$SUS.w1 + df$SUS.w2 + df$SUS.w3 + df$SUS.w4 + df$SUS.w5 +
  df$SUS.w6 + df$SUS.w7 + df$SUS.w8 + df$SUS.w9 + df$SUS.w10

print.statistics("SUS 1", df$SUS.w1)
print.statistics("SUS 2", df$SUS.w2)
print.statistics("SUS 3", df$SUS.w3)
print.statistics("SUS 4", df$SUS.w4)
print.statistics("SUS 5", df$SUS.w5)
print.statistics("SUS 6", df$SUS.w6)
print.statistics("SUS 7", df$SUS.w7)
print.statistics("SUS 8", df$SUS.w8)
print.statistics("SUS 9", df$SUS.w9)
print.statistics("SUS 10", df$SUS.w10)
print.statistics("SUS total", df$SUS.total)