args = commandArgs(trailingOnly = TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) == 0) {
    args[1] = 'c:/gitdownloads/hrp_nn/rproject1/train.csv'
}

#Read Data
data = read.csv (args[1], header = T)

# Random sampling
#samplesize = 0.60 * nrow(data)
#set.seed(80)
#index = sample(seq_len(nrow(data)), size = samplesize)

## Scale data for neural network
data <- data[, sapply(data, is.numeric)]

scaled_1 <- subset(data, select = c("Actual","Demand", "UnitDemand", "DemandAVG", "DeltaMonth"))
max <- apply(scaled_1, 2, max)
min <- apply(scaled_1, 2, min)
scaled = as.data.frame(scale(scaled_1, center = min, scale = max - min))
is.nan.data.frame <- function(x)
    do.call(cbind, lapply(x, is.nan))


#scaled$ReleaseStatusID[is.nan(scaled$ReleaseStatusID)] <- 1
#scaled$DeltaMonth[is.nan(scaled$DeltaMonth)] <- 1
## Fit neural network 

# load library
library(neuralnet)


# count columns (number of input nodes) and set hidden = columns/2
size = ncol(scaled)
size = round((size+1) / 2);

# fit neural network
set.seed(2)
start_time <- Sys.time()
NN = neuralnet(Actual ~ Demand + UnitDemand + DemandAVG + DeltaMonth, scaled, hidden = size, linear.output = T)
end_time <- Sys.time()

train_time = end_time - start_time
print(train_time)

# plot neural network
plot(NN)

save(NN, file = 'c:/gitdownloads/hrp_nn/rproject1/network')

###### UTIL #######
#Retrain a neural net
#NNetwork <- neuralnet(formula, data, startweights = NNetwork$weights)
