args = commandArgs(trailingOnly = TRUE)
# test if there is at least one argument: if not, return an error
if (length(args) == 0) {
    stop("At least one argument must be supplied (input file).n", call. = FALSE)
} else if (length(args) == 1) {
    # default output file
    args[2] = 'c:/gitdownloads/hrp_nn/rproject1/output.csv'
}

#load trained neural network
load('c:/gitdownloads/hrp_nn/rproject1/network')

#Read Data
data = read.csv(args[1], header = T)


## Scale data for neural network
data <- data[, sapply(data, is.numeric)]

# load library
library(neuralnet)

scaled <- subset(data, select = c("Demand", "Unit_Demand"))

NN.results <- compute(NN, scaled)

#save neural network
save(NN, file = 'c:/gitdownloads/hrp_nn/rproject1/network')
write.csv(NN.results,args[2])