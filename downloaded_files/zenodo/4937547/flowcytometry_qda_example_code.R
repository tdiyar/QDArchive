library(flowCore)
library(flowViz)
library(MASS)




#Import flow set after removing all wash wells
fs<-read.flowSet(path='/home/susanne/Desktop/rsync/canto/comp_fitness/comp_fitness_rep1_t96/T5_PD/',pattern=".fcs")

#Clean up the flow set (remove debris, doubles etc)
lengthfs<-length(fs) #checks how many fcs files are in flow set
clean.fs<-fs #makes new fs to put cleaned files in
for (i in 1:lengthfs){
  f<-fs[[i]]
  fsc.indices<-intersect(which(exprs(f)[,"FSC-A"]<250000),which(exprs(f)[,"FSC-A"]>50000)) #forward scatter
  fscw.indices<-intersect(which(exprs(f)[,"FSC-W"]>50000),which(exprs(f)[,"FSC-W"]<100000)) #side scatter (this setting excludes dividing cells!)
  ssc.indices<-which(exprs(f)[,"SSC-A"]<250000) #exclude debris
  perc.indices<-which(exprs(f)[,"PerCP-Cy5-5-A"]>1000) # exclude particles without chlorophyl
  a<-intersect(fsc.indices,fscw.indices)
  b<-intersect(a,ssc.indices)
  c<-intersect(b,perc.indices)
  f.clean<-f[c]
  clean.fs[[i]]<-f.clean
}

#transform the percyp and fitca channels
logtrans<-clean.fs
for (i in 1:lengthfs){
  f<-clean.fs[[i]]
  exprs(f)[,'PerCP-Cy5-5-A']<-log10(exprs(f)[,'PerCP-Cy5-5-A'])
  exprs(f)[,'FITC-A']<-log10(exprs(f)[,'FITC-A'])
  logtrans[[i]]<-f
}

#export only the fitca and percy values to txt files (easier to work with)
setwd("/home/susanne/Desktop/rsync/canto/comp_fitness/rep1_t96_T5PD/")
names<-as.vector(sampleNames(logtrans))
str<-strsplit(names,"_")
for (i in 1:lengthfs){
  f<-logtrans[[i]]
  percy<-exprs(f)[,'PerCP-Cy5-5-A']
  fitca<-exprs(f)[,'FITC-A']
  tab<-cbind(percy,fitca)
  colnames(tab)<-c('percy','fitca')
  outFile<-paste(str[[i]][3])
  write.table(tab,paste(outFile,".txt",sep=""),sep="\t",row.names=FALSE)
}

#qda
#first: make training data set out of parent 1 and parent 2

parent1A<-read.table("~/Desktop/temp/pilot2_rep1_0h/G5.txt",h=T)
parent1B<-read.table("~/Desktop/temp/pilot2_rep1_0h/G6.txt",h=T)
mix1<-read.table("~/Desktop/temp/pilot2_rep1_0h/G7.txt",h=T)
sam1A<-parent1A[sample(nrow(parent1A),500),]
sam1B<-parent1B[sample(nrow(parent1B),500),]
sam<-rbind(sam1A,sam1B)
parent<-as.vector(c(rep("1A",500),rep("1B",500)))
sam$parent<-parent

trainfit<-qda(parent~percy+fitca,data=sam)
p1<-predict(trainfit,mix1)
mix1up<-cbind(mix1,p1$class)
colnames(mix1up)<-c('percy','fitca','class')
dat1A<-(subset(mix1up,class=="1A"))
r1<-nrow(dat1A)/nrow(mix1up)
print(c(r1,1-r1))
plot(percy~fitca,mix1up,pch=as.numeric(class))

#quality control only: how good does qda perform on training set?
trainfit<-qda(parent~percy+fitca,CV=TRUE,data=sam)
ct<-table(sam$parent,trainfit$class)
sum(diag(prop.table(ct)))





#To export fcs files
#names<-as.list(paste(sampleNames(fs)))
#setwd("/home/susanne/Desktop/temp")
#for (i in 1:lengthfs){
#  f<-clean.fs[[i]]
#  outFile<-paste(names[[i]])
#  write.FCS(f,paste("clean_",outFile,sep="_"))
#}

#To count viable cells
fcount<-vector('list',lengthfs)

for (i in 1:lengthfs){
  c<-length(exprs(clean.fs[[i]])[,"FITC-A"])
  fcount[[i]]<-c
}
dim(fcount)<-c(lengthfs,1)
names<-as.list(paste(sampleNames(clean.fs)))
dim(names)<-c(lengthfs,1)
counter<-cbind(names,fcount)
colnames(counter)<-c('Name','Viable')

