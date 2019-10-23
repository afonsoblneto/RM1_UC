########################################################################
# This file was created in response to the PDCTI-RM1 2019/2020
# work assignment. 
#The graphic operations we perform here are based on the tutorial
# "Introduction to R and Exploratory Data Analysis"
#########################################################################

#Reading the data into R
sorting.dat <- read.csv(file = "D:/GitHub/RM1_UC/JoseCarlos/R_Code/expDB.dat")
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
#Summary statistics ans corresponding function, e.g. mean(), min(), range() or median()
summary(sorting.dat)
mean(sorting.dat[, 4])
range(sorting.dat[, 4])
var(sorting.dat[, 4])
min(sorting.dat[, 4])
median(sorting.dat[, 4])
# apply(sorting.dat[, 4], 2, range)

#####################################################################
#Graphical exploratory data analysis
##############
#Plot a histogram
#computes a histogram of the data values in the column Lgest_SubArray and Nr_Shifted_Values
hist(sorting.dat$Lgest_SubArray) 
hist(sorting.dat$Nr_Shifted_Values) 
hist(sorting.dat$Lgest_SubArray, 
     main="Histogram for Sorting Data", 
     xlab= "Lgest_SubArray", 
     border="blue", 
     col="green",
     xlim=c(100,70000),
     las=1, 
     breaks=5,
     prob = FALSE)



require(MASS)
#oldpar <- par(mfrow = c(3, 1))
hist(sorting.dat$Lgest_SubArray, col = "grey", main = "R default", ylab = "Frequency", freq = FALSE)
truehist(sorting.dat$Lgest_SubArray, nbins = "FD", col = "grey", main = "Freedman-Diaconis rule", ylab = "Frequency")
truehist(sorting.dat$Lgest_SubArray, nbins = "scott", col = "grey", main = "Scott's rule", ylab = "Frequency")
# par(oldpar)
# rm(oldpar)

##### CATEGORIZAR POR TIPO DE ALGORITMO DE ORDENAÇÃO
##############
#Boxplots
boxplot(sorting.dat$Lgest_SubArray, notch = TRUE, col = "grey", ylab = "Lgest_SubArray", main = "Boxplot of Lgest_SubArray", boxwex = 0.5)
boxplot(sorting.dat$Lgest_SubArray ~ sorting.dat$Array_Size, notch = FALSE, col = "grey",
        xlab = "Input array size", ylab = "Lgest_SubArray", main = "Boxplot of Lgest_SubArray by Input Array Size", 
        boxwex = 0.5, varwidth = TRUE)

boxplot(sorting.dat$Nr_Shifted_Values ~ sorting.dat$Array_Size, notch = FALSE, col = "grey",
        xlab = "Input array size", ylab = "Nr_Shifted_Values", main = "Boxplot of Nr_Shifted_Values by Sorting_Type", 
        boxwex = 0.5, varwidth = TRUE)


##########################################################
#Bivariate and multivariate graphical data analysis
###################
#Scatter plots
plot(x = sorting.dat$Sorting_Type, y = sorting.dat$Lgest_SubArray, main = "Scatter plot of Sorting_Type against Lgest_SubArray")
plot(x = sorting.dat$Sorting_Type, y = sorting.dat$Lgest_SubArray, main = "Scatter plot of Sorting_Type against Lgest_SubArray")
lines(lowess(x = sorting.dat$Sorting_Type, y = sorting.dat$Lgest_SubArray), col = "red", lwd = 1)
lowess(x = sorting.dat$Sorting_Type, y = sorting.dat$Lgest_SubArray)

plot(x = sorting.dat$Sorting_Type, y = sorting.dat$Nr_Shifted_Values, main = "Scatter plot of Array_Size against Nr_Shifted_Values")
plot(x = sorting.dat$Probability_Failure, y = sorting.dat$Lgest_SubArray, main = "Scatter plot of Probability_Failure against Lgest_SubArray")
lines(lowess(x = sorting.dat$Probability_Failure, y = sorting.dat$Lgest_SubArray), col = "red", lwd = 1)

#############
#### AJUSTAR RANGE X
#Scatter plot matrices
ArrSz <- sorting.dat$Array_Size
EPS <- sorting.dat$Probability_Failure
LgSArr <- sorting.dat$Lgest_SubArray
NrShfVl <- sorting.dat$Nr_Shifted_Values
SortTy <- sorting.dat$Sorting_Type

# pairs(cbind(ArrSz, EPS, LgSArr, NrShfVl), gap = 0, panel = panel.smooth)
# SortTy <- sorting.dat$Sorting_Type
# 
# pairs(cbind(ArrSz, EPS, LgSArr, NrShfVl), 
#       pch = c(21, 3)[SortTy], col = c("red", "blue", "black", "green")[SortTy], gap = 0)

pairs(cbind(ArrSz, EPS, LgSArr, NrShfVl), gap = 0, panel = panel.smooth)

pairs(cbind(ArrSz, EPS, LgSArr), 
      pch = c(21, 3)[SortTy], col = c("red", "blue")[SortTy], gap = 0)

pairs(cbind(ArrSz, EPS, NrShfVl), 
      pch = c(21, 3)[SortTy], col = c("red", "blue")[SortTy], gap = 0)

##############
#Density estimation
truehist(LgSArr, nbins = "FD", col = "grey", prob = TRUE, ylab = "Density", main = "Freedman-Diaconis rule")
lines(density(LgSArr), lwd = 2)
lines(density(LgSArr, adjust = 0.5), lwd = 1)
rug(LgSArr)
box()

truehist(NrShfVl, nbins = "FD", col = "grey", prob = TRUE, ylab = "Density", main = "Freedman-Diaconis rule")
lines(density(NrShfVl), lwd = 2)
lines(density(NrShfVl, adjust = 0.5), lwd = 1)
rug(NrShfVl)
box()

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
plot(x = LgSArr, y = ArrSz, pch = c(21, 3)[SortTy], col = c("red", "blue", "green", "yellow")[SortTy], 
     main = "Scatter plot of Largest Sorted Subarray against Input Array Size")
lines(lowess(x = LgSArr[SortTy == "Bubble_Sort"], y = ArrSz[SortTy == "Bubble_Sort"]), col = "red", lwd = 1)
lines(lowess(x = LgSArr[SortTy == "Quick_Sort"], y = ArrSz[SortTy == "Quick_Sort"]), col = "blue", lwd = 1)
lines(lowess(x = LgSArr[SortTy == "Insertion_Sort"], y = ArrSz[SortTy == "Insertion_Sort"]), col = "green", lwd = 1)
lines(lowess(x = LgSArr[SortTy == "Merge_Sort"], y = ArrSz[SortTy == "Merge_Sort"]), col = "yellow", lwd = 1)
legend("bottomright", legend = c("Bubble_Sort", "Quick_Sort", "Insertion_Sort", "Merge_Sort" ), col = c("red","blue","green","yellow"), pch = c(21, 3))

########################
#Gráfico Largest Subarray Size x EPS
plot(x = LgSArr, y = EPS, pch = c(21, 3)[SortTy], col = c("red", "blue", "green", "yellow")[SortTy], 
     main = "Scatter plot of Largest Sorted Subarray against Input Array Size")
lines(lowess(x = LgSArr[SortTy == "Bubble_Sort"], y = EPS[SortTy == "Bubble_Sort"]), col = "red", lwd = 1)
lines(lowess(x = LgSArr[SortTy == "Quick_Sort"], y = EPS[SortTy == "Quick_Sort"]), col = "blue", lwd = 1)
lines(lowess(x = LgSArr[SortTy == "Insertion_Sort"], y = EPS[SortTy == "Insertion_Sort"]), col = "green", lwd = 1)
lines(lowess(x = LgSArr[SortTy == "Merge_Sort"], y = EPS[SortTy == "Merge_Sort"]), col = "yellow", lwd = 1)
legend("topleft", legend = c("Bubble_Sort", "Quick_Sort", "Insertion_Sort", "Merge_Sort" ), col = c("red","blue","green","yellow"), pch = c(21, 3))


##############################################3
#Gráfico Nr. of Shifted Values x Input Array Size
plot(x = NrShfVl, y = ArrSz, pch = c(21, 3)[SortTy], col = c("red", "blue", "green", "yellow")[SortTy], 
     main = "Scatter plot of Largest Sorted Subarray against Input Array Size")
lines(lowess(x = NrShfVl[SortTy == "Bubble_Sort"], y = ArrSz[SortTy == "Bubble_Sort"]), col = "red", lwd = 1)
lines(lowess(x = NrShfVl[SortTy == "Quick_Sort"], y = ArrSz[SortTy == "Quick_Sort"]), col = "blue", lwd = 1)
lines(lowess(x = NrShfVl[SortTy == "Insertion_Sort"], y = ArrSz[SortTy == "Insertion_Sort"]), col = "green", lwd = 1)
lines(lowess(x = NrShfVl[SortTy == "Merge_Sort"], y = ArrSz[SortTy == "Merge_Sort"]), col = "yellow", lwd = 1)
legend("bottomright", legend = c("Bubble_Sort", "Quick_Sort", "Insertion_Sort", "Merge_Sort" ), col = c("red","blue","green","yellow"), pch = c(21, 3))


########################
#Gráfico Nr. of Shifted Values x EPS
plot(x = NrShfVl, y = EPS, pch = c(21, 3)[SortTy], col = c("red", "blue", "green", "yellow")[SortTy], 
     main = "Scatter plot of Largest Sorted Subarray against Input Array Size")
lines(lowess(x = NrShfVl[SortTy == "Bubble_Sort"], y = EPS[SortTy == "Bubble_Sort"]), col = "red", lwd = 1)
lines(lowess(x = NrShfVl[SortTy == "Quick_Sort"], y = EPS[SortTy == "Quick_Sort"]), col = "blue", lwd = 1)
lines(lowess(x = NrShfVl[SortTy == "Insertion_Sort"], y = EPS[SortTy == "Insertion_Sort"]), col = "green", lwd = 1)
lines(lowess(x = NrShfVl[SortTy == "Merge_Sort"], y = EPS[SortTy == "Merge_Sort"]), col = "yellow", lwd = 1)
legend("topleft", legend = c("Bubble_Sort", "Quick_Sort", "Insertion_Sort", "Merge_Sort" ), col = c("red","blue","green","yellow"), pch = c(21, 3))


