########################################################################
# This file was created in response to the PDCTI-RM1 2019/2020
# work assignment. 
#The graphic operations we perform here are based on the tutorial
# "Introduction to R and Exploratory Data Analysis"
#########################################################################

#Reading the data into R
sorting.dat <- read.csv(file = "experimentDB.dat")
# sorting.dat[, 18] <- as.factor(scp.dat[, 18])
# levels(scp.dat[, 18]) <- c("Coal", "Oil")



# posso olhar o numero de linhas usando nrow()
print (nrow(sorting.dat)) 
print (ncol(sorting.dat)) 

#Print the contents of that object to the screen
sorting.dat
names(sorting.dat)
str(sorting.dat)

##############
#Print the contents of that object to the screen
#Summary statistics and corresponding function, e.g. mean(), min(), range() or median()
#Variable Lgest_Subarray
summary(sorting.dat)
mean(sorting.dat[, 4])
sd(sorting.dat[, 4])
range(sorting.dat[, 4])
var(sorting.dat[, 4])
min(sorting.dat[, 4])
median(sorting.dat[, 4])
#apply(sorting.dat[, 4], 2, mean)

#Variable Nr_Shifted_Values
mean(sorting.dat[, 5])
sd(sorting.dat[, 5])

#####################################################################
#Graphical exploratory data analysis
##############
#Plot a histogram
#computes a histogram of the data values in the column Lgest_SubArray and Nr_Shifted_Values
hist(sorting.dat$Lgest_SubArray) 
# hist(sorting.dat$Lgest_SubArray, 
#      main="Histogram for Sorting Data", 
#      xlab= "Lgest_SubArray", 
#      border="blue", 
#      col="green",
#      xlim=c(100,1000),
#      las=1, 
#      breaks=5,
#      prob = FALSE)
hist(sorting.dat$Lgest_SubArray, xlim=c(1, 10000), freq=TRUE, breaks=10)
plot(density((sorting.dat$Lgest_SubArray), col="red"))


##################################################################
#Density
plot(density(sorting.dat$Lgest_SubArray),main = "Sampley density plot", xlab = "Largest Sorted SubArray Size")
abline(v=mean(sorting.dat$Lgest_SubArray), col = "black")
lines(density(sorting.dat$Lgest_SubArray),col = "blue",lwd=2)

plot(density(sorting.dat$Nr_Shifted_Values),main = "Sampley density plot", xlab = "Number of Shifted values")
abline(v=mean(sorting.dat$Nr_Shifted_Values), col = "black")
lines(density(sorting.dat$Nr_Shifted_Values),col = "blue",lwd=2)

########################################################################################
#Plot a histogram
#computes a histogram of the data values in the column Lgest_SubArray

require(ggplot2)
qplot(sorting.dat$Lgest_SubArray,
      geom="histogram",
      binwidth = 100,  #500
      main = "Histogram for Sorting Algorithms", 
      xlab = "Largest Sorted SubArray Size", 
      ylab = "Frequency",
      fill=I("blue"), 
      col=I("black"), 
      alpha=I(.4),
      xlim=c(1,3000),#100,10000
      ylim=c(0,40)) 


# ggplot(data=sorting.dat, aes(x=sorting.dat$Lgest_SubArray)) + 
#   geom_histogram(breaks=seq(100, 10000, by = 250), col="red", 
#                  fill="green", 
#                  alpha = .4) + 
#   labs(title="Histogram for Sorting Algorithms", x="Largest Sorted SubArray", y="Frequency") + 
#   xlim(c(100,10000)) + 
#   ylim(c(0,50)) +
#   geom_density(col=2) 

#Quantile quantile plots
qqnorm(sorting.dat$Lgest_SubArray)
qqline(sorting.dat$Lgest_SubArray)

df <- data.frame(y = sorting.dat$Lgest_SubArray)
p <- ggplot(df, aes(sample = y))
p + stat_qq() + stat_qq_line() +
labs(title="Normal Q-Q Plot", x="Theoretical Quantiles", y= "Sample Quantiles")



#oldpar <- par(mfrow = c(3, 1))
hist(sorting.dat$Lgest_SubArray, col = "grey", main = "Histogram for Sorting Algorithms", xlab= "Lgest_SubArray", ylab = "Frequency", freq = TRUE)
# truehist(sorting.dat$Lgest_SubArray, nbins = "FD", col = "grey", main = "Freedman-Diaconis rule", ylab = "Frequency")
# truehist(sorting.dat$Lgest_SubArray, nbins = "scott", col = "grey", main = "Scott's rule", ylab = "Frequency")
# par(oldpar)
# rm(oldpar)

#computes a histogram of the data values in the column Nr_Shifted_Values
#hist(sorting.dat$Nr_Shifted_Values)
qplot(sorting.dat$Nr_Shifted_Values,
      geom="histogram",
      binwidth = 200,  
      main = "Histogram for Sorting Algorithms", 
      xlab = "Number of Shifted values", 
      ylab = "Frequency",
      fill=I("blue"), 
      col=I("black"), 
      alpha=I(.4),
      xlim=c(0,10000),
      ylim=c(0,30)) 

#Quantile quantile plots
qqnorm(sorting.dat$Nr_Shifted_Values)
qqline(sorting.dat$Nr_Shifted_Values)

df <- data.frame(y = sorting.dat$Nr_Shifted_Values)
p <- ggplot(df, aes(sample = y))
p + stat_qq() + stat_qq_line() +
  labs(title="Normal Q-Q Plot", x="Theoretical Quantiles", y= "Sample Quantiles")

#######################################################
# # Histogram
# hist(y, freq=TRUE, breaks=10)
# 
# # Density Plots
# plot(density(y), col="red")
# 
# # QQ-plots for Normal Distribution
# qqnorm(as.vector(y))
# qqline(as.vector(y))
#######################################################

##########################################################
# Scatter plots: with labels
#############################################################
plot(sorting.dat[,2], sorting.dat[,4], pch=20, col="blue", xlab = "Input Array Size (n)", 
     ylab = "Largest Sorted Subarray Size", main="Symbols and Labels")

plot(x = sorting.dat[,2], y = sorting.dat[,4], xlab = "Input Array Size (n)", 
     ylab = "Largest Sorted Subarray Size", main = "Input Array size (n) against Largest Sorted Subarray Size")
lines(lowess(x = sorting.dat[,2], y = sorting.dat[,4]), col = "red", lwd = 1)

plot(x = sorting.dat[,3], y = sorting.dat[,4], xlab = "Probability of Failure (eps)", 
     ylab = "Largest Sorted Subarray Size", main = "Probability of Failure (eps) against Probability of Failure")
lines(lowess(x = sorting.dat[,3], y = sorting.dat[,4]), col = "red", lwd = 1)

plot(x = sorting.dat[,2], y = sorting.dat[,5], xlab = "Input Array Size (n)", 
     ylab = "Number of Shifted Values", main = "Input Array size (n) against Number of Shifted Values")
lines(lowess(x = sorting.dat[,2], y = sorting.dat[,5]), col = "red", lwd = 1)

plot(x = sorting.dat[,3], y = sorting.dat[,5], col="blue", xlab = "Probability of Failure (eps)", 
     ylab = "Number of Shifted Values", main = "Probability of Failure (eps) against Number of Shifted Values")
lines(lowess(x = sorting.dat[,3], y = sorting.dat[,5]), col = "red", lwd = 1)


#text(y[,1]+0.03, y[,2], rownames(y))





##############
require(MASS)
#Density estimation
truehist(LgSArr, nbins = "FD", col = "grey", prob = TRUE, xlab = "Largest Sorted Subarray Size", ylab = "Density", main = "Freedman-Diaconis rule")
lines(density(LgSArr), lwd = 2)
lines(density(LgSArr, adjust = 0.5), lwd = 1)
rug(LgSArr)
box()

truehist(NrShfVl, nbins = "FD", col = "grey", prob = TRUE, xlab = "Number of Shifted Values", ylab = "Density", main = "Freedman-Diaconis rule")
lines(density(NrShfVl), lwd = 2)
lines(density(NrShfVl, adjust = 0.5), lwd = 1)
rug(NrShfVl)
box()

#############################################################
#Boxplots
#computes a Boxplot of the data values Lgest_SubArray X Input_Array_Size (n)
#boxplot(sorting.dat$Lgest_SubArray, notch = TRUE, col = "grey", ylab = "Lgest_SubArray", main = "Boxplot of Largest Sorted SubArray", boxwex = 0.5)
boxplot(sorting.dat$Lgest_SubArray ~ sorting.dat$Input_Array_Size, notch = FALSE, col = "grey", ylim=c(-20, 1100),
        xlab = "Input array size (n)", ylab = "Largest Sorted SubArray Size", main = "Boxplot of Largest Sorted SubArray by Input Array Size", 
        boxwex = 0.5, varwidth = TRUE)
#log="y", ylim=c(.1, 100000),

#computes a Boxplot of the data values Lgest_SubArray X Probability of Failure (EPS)
boxplot(sorting.dat$Lgest_SubArray ~ sorting.dat$Prob_of_Failure, notch = FALSE, col = "grey",  ylim=c(-20, 1100),
        xlab = "Probability of Failure (EPS)", ylab = "Largest Sorted SubArray Size (log)", main = "Boxplot of Largest Sorted SubArray by Probability of Failure", 
        boxwex = 0.5, varwidth = TRUE)
#log="y", ylim=c(10, 100000),

#computes a Boxplot of the data values Nr_Shifted_Values X Input_Array_Size (n)
boxplot(sorting.dat$Nr_Shifted_Values ~ sorting.dat$Input_Array_Size, notch = FALSE, col = "grey", 
        xlab = "Input array size (n)", ylab = "Number of Shifted Values", main = "Boxplot of Number of Shifted Values by Input Array Size", 
        boxwex = 0.5, varwidth = TRUE)

#log="y", ylim=c(.1, 100000),

#computes a Boxplot of the data values Nr_Shifted_Values X Probability of Failure (EPS)
boxplot(sorting.dat$Nr_Shifted_Values ~ sorting.dat$Prob_of_Failure, notch = FALSE, col = "grey", 
        xlab = "Probability of Failure (EPS)", ylab = "Number of Shifted Values", main = "Boxplot of Number of Shifted Values by Probability of Failure", 
        boxwex = 0.5, varwidth = TRUE)



# ggplot(sorting.dat, aes(x=sorting.dat$Input_Array_Size, y=sorting.dat$Lgest_SubArray)) + 
#   geom_boxplot(outlier.colour="red", outlier.shape=8,
#                outlier.size=4)


boxplot(sorting.dat$Lgest_SubArray ~ sorting.dat$Sorting_Type, notch = FALSE, col = "grey",log="y", ylim=c(10, 100000),
        xlab = "Sorting Algorithm", ylab = "Nr. of Shifted Values", main = "Boxplot of Largest Sorted Subarray Size by Sorting Type", 
        boxwex = 0.5, varwidth = TRUE)


boxplot(sorting.dat$Nr_Shifted_Values ~ sorting.dat$Sorting_Type, notch = FALSE, col = "grey",
        xlab = "Sorting Algorithm", ylab = "Nr. of Shifted Values", main = "Boxplot of Nr. of Shifted Values by Sorting Type", 
        boxwex = 0.5, varwidth = TRUE)

##########################################################
#Bivariate and multivariate graphical data analysis
###################
#Scatter plots
#plot(x = sorting.dat$Sorting_Type, y = sorting.dat$Lgest_SubArray, main = "Scatter plot of Sorting_Type against Lgest_SubArray")
plot(x = sorting.dat$Sorting_Type, y = sorting.dat$Lgest_SubArray, main = "Scatter plot of Sorting_Type against Lgest_SubArray")
lines(lowess(x = sorting.dat$Sorting_Type, y = sorting.dat$Lgest_SubArray), col = "red", lwd = 1)
lowess(x = sorting.dat$Sorting_Type, y = sorting.dat$Lgest_SubArray)

plot(x = sorting.dat$Sorting_Type, y = sorting.dat$Nr_Shifted_Values, main = "Scatter plot of Array_Size against Nr_Shifted_Values")
#plot(x = sorting.dat$Probability_Failure, y = sorting.dat$Lgest_SubArray, main = "Scatter plot of Probability_Failure against Lgest_SubArray")
lines(lowess(x = sorting.dat$Sorting_Type, y = sorting.dat$Lgest_SubArray), col = "red", lwd = 1)

#############
#Scatter plot matrices
ArrSz <- sorting.dat$Input_Array_Size
EPS <- sorting.dat$Prob_of_Failure
LgSArr <- sorting.dat$Lgest_SubArray
NrShfVl <- sorting.dat$Nr_Shifted_Values
SortTy <- sorting.dat$Sorting_Type

# pairs(cbind(ArrSz, EPS, LgSArr, NrShfVl), gap = 0, panel = panel.smooth)
# SortTy <- sorting.dat$Sorting_Type
# 
# pairs(cbind(ArrSz, EPS, LgSArr, NrShfVl), 
#       pch = c(21, 3)[SortTy], col = c("red", "blue", "black", "green")[SortTy], gap = 0)

pairs(cbind(ArrSz, EPS, LgSArr, NrShfVl), gap = 0, panel = panel.smooth)

pairs(cbind(ArrSz, EPS, LgSArr),  gap = 0,  panel = panel.smooth)

pairs(cbind(ArrSz, EPS, NrShfVl), gap = 0,  panel = panel.smooth)

pairs(cbind(ArrSz, EPS, LgSArr), 
      pch = c(21, 3)[SortTy], col = c("red", "blue")[SortTy], gap = 0,  panel = panel.smooth)

pairs(cbind(ArrSz, EPS, NrShfVl), 
      pch = c(21, 3)[SortTy], col = c("red", "blue")[SortTy], gap = 0,  panel = panel.smooth)



##############
#Quantile quantile plots
qqnorm(LgSArr)
qqline(LgSArr)

qqnorm(NrShfVl)
qqline(NrShfVl)

######################
#Coded scatter plots and other enhancements

########################
#Gráfico Largest Subarray Size x Input Array Size
plot(x = ArrSz, y = LgSArr, pch = c(21, 3)[SortTy], col = c("red", "blue", "green", "yellow")[SortTy], 
     main = "Scatter plot of Largest Sorted Subarray against Input Array Size")
lines(lowess(x = ArrSz[SortTy == "Bubble_Sort"], y = LgSArr[SortTy == "Bubble_Sort"]), col = "red", lwd = 1)
lines(lowess(x = ArrSz[SortTy == "Quick_Sort"], y = LgSArr[SortTy == "Quick_Sort"]), col = "blue", lwd = 1)
lines(lowess(x = ArrSz[SortTy == "Insertion_Sort"], y = LgSArr[SortTy == "Insertion_Sort"]), col = "green", lwd = 1)
lines(lowess(x = ArrSz[SortTy == "Merge_Sort"], y = LgSArr[SortTy == "Merge_Sort"]), col = "yellow", lwd = 1)
legend("topleft", legend = c("Bubble_Sort", "Quick_Sort", "Insertion_Sort", "Merge_Sort" ), col = c("red","blue","green","yellow"), pch = c(21, 3))

########################
#Gráfico Largest Subarray Size x EPS
plot(x = EPS, y = LgSArr, pch = c(21, 3)[SortTy], col = c("red", "blue", "green", "yellow")[SortTy], 
     main = "Scatter plot of Largest Sorted Subarray against Input Array Size")
lines(lowess(x =EPS[SortTy == "Bubble_Sort"], y = LgSArr[SortTy == "Bubble_Sort"]), col = "red", lwd = 1)
lines(lowess(x = EPS[SortTy == "Quick_Sort"], y = LgSArr[SortTy == "Quick_Sort"]), col = "blue", lwd = 1)
lines(lowess(x = EPS[SortTy == "Insertion_Sort"], y = LgSArr[SortTy == "Insertion_Sort"]), col = "green", lwd = 1)
lines(lowess(x = EPS[SortTy == "Merge_Sort"], y = LgSArr[SortTy == "Merge_Sort"]), col = "yellow", lwd = 1)
legend("topleft", legend = c("Bubble_Sort", "Quick_Sort", "Insertion_Sort", "Merge_Sort" ), col = c("red","blue","green","yellow"), pch = c(21, 3))


##############################################3
#Gráfico Nr. of Shifted Values x Input Array Size
plot(x = ArrSz, y = NrShfVl, pch = c(21, 3)[SortTy], col = c("red", "blue", "green", "yellow")[SortTy], 
     main = "Scatter plot of Largest Sorted Subarray against Input Array Size")
lines(lowess(x = ArrSz[SortTy == "Bubble_Sort"], y = NrShfVl[SortTy == "Bubble_Sort"]), col = "red", lwd = 1)
lines(lowess(x = ArrSzl[SortTy == "Quick_Sort"], y = NrShfVl[SortTy == "Quick_Sort"]), col = "blue", lwd = 1)
lines(lowess(x = ArrSzl[SortTy == "Insertion_Sort"], y = NrShfVl[SortTy == "Insertion_Sort"]), col = "green", lwd = 1)
lines(lowess(x = ArrSzl[SortTy == "Merge_Sort"], y = NrShfVl[SortTy == "Merge_Sort"]), col = "yellow", lwd = 1)
legend("topleft", legend = c("Bubble_Sort", "Quick_Sort", "Insertion_Sort", "Merge_Sort" ), col = c("red","blue","green","yellow"), pch = c(21, 3))


########################
#Gráfico Nr. of Shifted Values x EPS
plot(x = EPS, y = NrShfVl, pch = c(21, 3)[SortTy], col = c("red", "blue", "green", "yellow")[SortTy], 
     main = "Scatter plot of Largest Sorted Subarray against Input Array Size")
lines(lowess(x = EPS[SortTy == "Bubble_Sort"], y = NrShfVl[SortTy == "Bubble_Sort"]), col = "red", lwd = 1)
lines(lowess(x = EPS[SortTy == "Quick_Sort"], y = NrShfVl[SortTy == "Quick_Sort"]), col = "blue", lwd = 1)
lines(lowess(x = EPS[SortTy == "Insertion_Sort"], y = NrShfVl[SortTy == "Insertion_Sort"]), col = "green", lwd = 1)
lines(lowess(x = EPS[SortTy == "Merge_Sort"], y = NrShfVl[SortTy == "Merge_Sort"]), col = "yellow", lwd = 1)
legend("topleft", legend = c("Bubble_Sort", "Quick_Sort", "Insertion_Sort", "Merge_Sort" ), col = c("red","blue","green","yellow"), pch = c(21, 3))

