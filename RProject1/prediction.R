args = commandArgs(trailingOnly = TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) == 0) {
    stop("At least one argument must be supplied (input file).n", call. = FALSE)
} else if (length(args) == 1) {
    # default output file
    args[2] = 'c:/gitdownloads/hrp_nn/rproject1/output.csv'
    #x = 'c:/gitdownloads/hrp_nn/rproject1/output.csv'
}

#load trained neural network
load('E:/git downloads/HRP_NN/RProject1/network')

#Read Data
data = read.csv(args[1], header = T)


# Unneded as we select a subset which is only the required cumeric columns
#data <- data[, sapply(data, is.numeric)]

# load library
library(neuralnet)

scaled <- subset(data, select = c("Demand","UnitDemand","DemandAVG","DeltaMonth"))

NN.results <- compute(NN, scaled)
#NN = neuralnet(Actual ~ AccountID + CountryID + OrgID + PortfolioID + ReleaseID + Demand + UnitDemand + DemandAVG + DeltaMonth, scaled,  startweights = NN$weights, stepmax = 1e6)

#####ADD ERROR TO DISPLAY, IF NOT JUST PLOT###
#print(NN$result.matrix)

#save neural network and output
#No need to save unless re-trained
#save(NN, file = 'c:/gitdownloads/hrp_nn/rproject1/network')

#add results column to the original data
results <- as.numeric(as.character(NN.results$net.result))
results <- abs(results)
data$prediction <- paste(results)
#fixedPrediction <- results + scaled$DemandAVG
#data$prediction <- paste(fixedPrediction)

#df$x <- paste(df$n, df$s)
#df
#   n  s     b    x
# 1 2 aa  TRUE 2 aa
# 2 3 bb FALSE 3 bb
# 3 5 cc  TRUE 5 cc
write.csv(data, args[2],row.names = F)