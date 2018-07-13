args = commandArgs(trailingOnly = TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) == 0) {
    args[1] = 'e:/git downloads/hrp_nn/rproject1/train.csv'
    args[2] = 'e:/git downloads/hrp_nn/rproject1/output.csv'
} else if (length(args) == 1) {
    # default output file
    args[2] = 'e:/git downloads/hrp_nn/rproject1/output.csv'
}

#temp
#args[1] = 'c:/gitdownloads/hrp_nn/rproject1/small.csv'

#Read Data
data = read.csv (args[1], header = T)

# Random sampling
#samplesize = 0.60 * nrow(data)
#set.seed(80)
#index = sample(seq_len(nrow(data)), size = samplesize)

## Scale data for neural network
data <- data[, sapply(data, is.numeric)]

max <- apply(data, 2, max)
min <- apply(data, 2, min)
scaled = as.data.frame(scale(data, center = min, scale = max - min))

## Fit neural network 

# load library
library(neuralnet)

# creating training and test set
#trainNN = scaled[index,]
#testNN = scaled[-index,]

# count columns (number of input nodes) and set hidden = columns/2
size = ncol(scaled)
size = round((size+1) / 2);

# fit neural network
set.seed(2)
start_time <- Sys.time()
NN = neuralnet(Actual ~ AccountID + CountryID + OrgID + PortfolioID + ReleaseID + ReleaseStatusID + Demand + UnitDemand, data, hidden = size, linear.output = T)
end_time <- Sys.time()

train_time = end_time - start_time
print(train_time)

# plot neural network
plot(NN)

#save neural network
save(NN, file = 'c:/gitdownloads/hrp_nn/rproject1/network')