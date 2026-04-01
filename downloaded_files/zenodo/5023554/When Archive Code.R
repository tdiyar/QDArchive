########################################################
###### When males outlive females ######################
########################################################

library(OIsurv)   # loads also 'survival'

setwd("...")
LVK <- read.table(file="When Archive Data.txt", header=T)
head(LVK) 

########################################################
###### COX ONE #########################################
########################################################

###### group variables as 0-1 (factor): ################
 
fsex <- rep(NA, length(LVK$sex))
fsex[which(LVK$sex=="F")] <- 0
fsex[which(LVK$sex=="M")] <- 1

ftemp <- rep(NA, length(LVK$temp))
ftemp[which(LVK$temp==16)] <- 0
ftemp[which(LVK$temp==20)] <- 1

LVK$fsex <- fsex
LVK$ftemp <- ftemp 

###### coxph - model comparison ########################

iifcox <- coxph(Surv(LS, fin) ~ clone * fsex * ftemp, data=LVK)
ifcox <- coxph(Surv(LS, fin) ~ fsex * ftemp, data=LVK)
# AIC(iifcox) 879.682
# AIC(ifcox) 905.0447

aics <- c(AIC(iifcox), AIC(ifcox))
rls <- vector()
for (i in 1:length(aics)) {
  rellik <- exp((min(aics)-aics[i])/2)
  rls <- c(rls, rellik)
}
rls # 1.000000e+00 3.108553e-06
#summary(iifcox)

########################################################
####### COX CLONES SEPARATELY ##########################
########################################################

LVKK <- LVK[which(LVK$clone=="K"),]                     
Kifcox <- coxph(Surv(LS, fin) ~ fsex * ftemp, data=LVKK)
summary(Kifcox) # AIC=279.213

LVKT <- LVK[which(LVK$clone=="T"),]                     
Tifcox <- coxph(Surv(LS, fin) ~ fsex * ftemp, data=LVKT)
summary(Tifcox) # AIC=97.212

LVKB <- LVK[which(LVK$clone=="B"),]                     
Bifcox <- coxph(Surv(LS, fin) ~ fsex * ftemp, data=LVKB)
summary(Bifcox) # AIC=288.042

########################################################
####### SURVIVAL CURVES ################################
########################################################

attach(LVK)
so16FT <- Surv(LS[temp==16 & sex=="F" & clone=="T"], 
               fin[temp==16 & sex=="F" & clone=="T"])
so16FB <- Surv(LS[temp==16 & sex=="F" & clone=="B"], 
               fin[temp==16 & sex=="F" & clone=="B"])
so16FK <- Surv(LS[temp==16 & sex=="F" & clone=="K"], 
               fin[temp==16 & sex=="F" & clone=="K"])

so16MT <- Surv(LS[temp==16 & sex=="M" & clone=="T"], 
               fin[temp==16 & sex=="M" & clone=="T"])
so16MB <- Surv(LS[temp==16 & sex=="M" & clone=="B"], 
               fin[temp==16 & sex=="M" & clone=="B"])
so16MK <- Surv(LS[temp==16 & sex=="M" & clone=="K"], 
               fin[temp==16 & sex=="M" & clone=="K"])

so20FT <- Surv(LS[temp==20 & sex=="F" & clone=="T"], 
               fin[temp==20 & sex=="F" & clone=="T"])
so20FB <- Surv(LS[temp==20 & sex=="F" & clone=="B"], 
               fin[temp==20 & sex=="F" & clone=="B"])
so20FK <- Surv(LS[temp==20 & sex=="F" & clone=="K"], 
               fin[temp==20 & sex=="F" & clone=="K"])

so20MT <- Surv(LS[temp==20 & sex=="M" & clone=="T"], 
               fin[temp==20 & sex=="M" & clone=="T"])
so20MB <- Surv(LS[temp==20 & sex=="M" & clone=="B"], 
               fin[temp==20 & sex=="M" & clone=="B"])
so20MK <- Surv(LS[temp==20 & sex=="M" & clone=="K"], 
               fin[temp==20 & sex=="M" & clone=="K"])
detach(LVK)

sf16FT <- survfit(so16FT ~ 1)
sf16FB <- survfit(so16FB ~ 1)
sf16FK <- survfit(so16FK ~ 1)

sf16MT <- survfit(so16MT ~ 1)
sf16MB <- survfit(so16MB ~ 1)
sf16MK <- survfit(so16MK ~ 1)

sf20FT <- survfit(so20FT ~ 1)
sf20FB <- survfit(so20FB ~ 1)
sf20FK <- survfit(so20FK ~ 1)

sf20MT <- survfit(so20MT ~ 1)
sf20MB <- survfit(so20MB ~ 1)
sf20MK <- survfit(so20MK ~ 1)

########################################################
###### FIG. 2 ##########################################
########################################################

pdf(file="Figure 2 archive.pdf", 8, 9)
par(mfcol=c(3,2))
par(mar=c(4.5, 4.5, 1.5, 2))

plot(sf16FK, col="deepskyblue3", lwd=c(3,1,1), lty=c(1,3,3), 
     las=1, cex.lab=1.2, xlim=c(0,140), ylab="Survival function")
title("Females K", line = -2, adj=0.9)
lines(sf20FK, col="red3", lwd=c(3,1,1), lty=c(1,3,3), las=1)

plot(sf16FT, col="deepskyblue3", lwd=c(3,1,1), lty=c(1,3,3), 
     las=1, cex.lab=1.2, xlim=c(0,140), ylab="Survival function")
title("Females T", line = -2, adj=0.9)
lines(sf20FT, col="red3", lwd=c(3,1,1), lty=c(1,3,3), las=1)

plot(sf16FB, col="deepskyblue3", lwd=c(3,1,1), lty=c(1,3,3), 
     las=1, cex.lab=1.2, xlim=c(0,140), 
     xlab="Age (days)", ylab="Survival function")
title("Females B", line = -2, adj=0.9)
lines(sf20FB, col="red3", lwd=c(3,1,1), lty=c(1,3,3), las=1)

plot(sf16MK, col="deepskyblue3", lwd=c(3,1,1), lty=c(1,3,3), 
     las=1, xlim=c(0,140))
title("Males K", line = -2, adj=0.9)
lines(sf20MK, col="red3", lwd=c(3,1,1), lty=c(1,3,3), las=1)

plot(sf16MT, col="deepskyblue3", lwd=c(3,1,1), lty=c(1,3,3), 
     las=1, xlim=c(0,140))
title("Males T", line = -2, adj=0.9)
lines(sf20MT, col="red3", lwd=c(3,1,1), lty=c(1,3,3), las=1)

plot(sf16MB, col="deepskyblue3", lwd=c(3,1,1), 
     lty=c(1,3,3), las=1, cex.lab=1.2,
     xlim=c(0,140), xlab="Age (days)")
title("Males B", line = -2, adj=0.9)
lines(sf20MB, col="red3", lwd=c(3,1,1), lty=c(1,3,3), las=1)
dev.off()

###################################################################
###################################################################


