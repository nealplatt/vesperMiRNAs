setwd("D:/Dropbox/work/projects/vesperSmallRNAs/RData/")


vsTEsSim=read.table("vsTEs.tab", sep="\t", header=TRUE)
vsDNASim=read.table("vsDNAs.tab", sep="\t", header=TRUE)
vsHelitronSim=read.table("vsHelitrons.tab", sep="\t", header=TRUE)
vsHatSim=read.table("vsHATs.tab", sep="\t", header=TRUE)
vsBAR1Sim=read.table("vsBAR1_ML.tab", sep="\t", header=TRUE)


vsTEsAct=read.table("TE_ActualTEpercents.txt", sep="\t")
vsDNAAct=read.table("DNA_ActualTEpercents.txt", sep="\t")
vsHelitronAct=read.table("helitron_ActualTEpercents.txt", sep="\t")
vsHatAct=read.table("hAT_ActualTEpercents.txt", sep="\t")
vsBAR1Act=read.table("BAR1_ML_ActualTEpercents.txt", sep="\t")

labels=c("M.occultus (L)", "M. occultus (T)", "M. yumanensis (L)", "M. yumanensis (T)", "E. fuscus", "A. pallidus", "Cow", "Dog", "Cat", "Horse", "Pig", "Hedgehog", "Kangaroo Rat", "Squirrel", "Rabbit")

#plot vs TEs
svg("vsTEs.svg", width=7, height=7)
  #plot vs TEs
  boxplot(vsTEsSim, range=0, las=2, ylim=c(0,0.6))
  title(main="vsTEs")
  points(vsTEsAct, col="red", pch=19)
dev.off()

#plot vs DNAs
svg("vsDNAs.svg", width=7, height=7)
  boxplot(vsDNASim, range=0, las=2, ylim=c(0,0.125))
  title(main="vs DNA transposons")
  points(vsDNAAct, col="red", pch=19)
dev.off()

#plot vs hATs
svg("vshATs.svg", width=7, height=7)
  boxplot(vsHatSim, range=0, las=2, ylim=c(0,0.1))
  title(main="vs hATs")
  points(vsHatAct, col="red", pch=19)
dev.off()

#plot vs Helitrons
svg("vsHelitrons.svg", width=7, height=7)
  boxplot(vsHelitronSim, range=0, las=2, ylim=c(0,0.05))
  title(main="vs hATs")
  points(vsHelitronAct, col="red", pch=19)
dev.off()

#plot vs BAR1_ML
svg("vsBAR1.svg", width=7, height=7)
  boxplot(vsBAR1Sim, range=0, las=2, ylim=c(0,0.05))
  title(main="vs BAR1_ML")
  points(vsBAR1Act, col="red", pch=19)
dev.off()

vsBAR1Act$v2
