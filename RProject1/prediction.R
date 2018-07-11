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

#### MAY NOT NEED TO SCALE
#max <- apply(data, 2, max)
#min <- apply(data, 2, min)
#scaled = as.data.frame(scale(data, center = min, scale = max - min))


# load library
library(neuralnet)


#Test the resulting output
#temp_test <- subset(testset, select = c("fcfps", "earnings_growth", "de", "mcap", "current_ratio"))
#head(temp_test)
#nn.results <- compute(nn, temp_test)
scaled <- subset(data, select = c("Demand", "Unit_Demand"))

NN.results <- compute(NN, scaled)

# plot neural network
#plot(NN)

#save neural network
save(NN, file = 'c:/gitdownloads/hrp_nn/rproject1/network')
write.csv(NN.results,args[2])