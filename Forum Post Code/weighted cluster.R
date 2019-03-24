library(WeightedCluster)

data(mvad)
head(mvad)
aggMvad <- wcAggregateCases(mvad[, 17:86])
print(aggMvad)
uniqueMvad <- mvad[aggMvad$aggIndex, 17:86]
mvad.seq <- seqdef(uniqueMvad, weights = aggMvad$aggWeights)
diss <- seqdist(mvad.seq, method = "HAM")
averageClust <- hclust(as.dist(diss), method = "average", members = aggMvad$aggWeights)
averageTree <- as.seqtree(averageClust, seqdata = mvad.seq, diss = diss, ncluster = 6)
seqtreedisplay(averageTree, type = "d", border = NA, showdepth = TRUE)
