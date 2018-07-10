#Read Data
data = read.csv('c:/users/najib/source/repos/rproject1/rproject1/small.csv', header = T)

# Random sampling
samplesize = 0.60 * nrow(data)
set.seed(80)
index = sample(seq_len(nrow(data)), size = samplesize)

# Create training and test set
datatrain = data[index,]
datatest = data[-index,]

## Scale data for neural network
data <- data[, sapply(data, is.numeric)]

max <- apply(data, 2, max)
min <- apply(data, 2, min)
scaled = as.data.frame(scale(data, center = min, scale = max - min))

## Fit neural network 

# install library
install.packages("neuralnet")

# load library
library(neuralnet)

# creating training and test set
trainNN = scaled[index,]
testNN = scaled[-index,]

# fit neural network
set.seed(2)
NN = neuralnet(Actual ~  Demand + Unit_Demand, trainNN, hidden = 3, linear.output = T)

# plot neural network
plot(NN)