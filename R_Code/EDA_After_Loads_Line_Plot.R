# Load data file
expDB <- read.csv("D:/GitHub/RM1_UC/R_Code/expDB.dat", header=FALSE)

# Deleting column Num_Shifts 
expDB <- expDB[, -5]

# Naming columns
colnames(expDB) <- c("Sort_Method", "Sequence_Size", "Prob_Fail", "Size_Larg_Sort_Array")

# Changing the col "Sort_Method" to categorical
expDB[, 1] <- as.factor(expDB[, 1])
list_sort <- c("Bubble_Sort","Insertion_Sort","Merge_Sort","Quick_Sort") 
levels(expDB[, 1]) <- list_sort

# Changing the col "Sequence_Size" from numerical to categorical
Num_Sequence_Size <- expDB[, 2]
expDB <- cbind(expDB, Num_Sequence_Size)
expDB[, 2] <- as.factor(expDB[, 2])
list_n <- c("100","500","1000","2500","5000","7500","10000")
levels(expDB[, 2]) <- list_n

# Changing the col "Prob_Fail" from numerical to categorical
Num_Prob_Fail <- expDB[, 3]
expDB <- cbind(expDB, Num_Prob_Fail)
expDB[, 3] <- as.factor(expDB[, 3])
# Change the levels of the "Prob_Fail" based on categorical association
list_exp <- c("0.25%","0.5%","0.75%","1%","1.25%","1.5%","1.75%")
levels(expDB[, 3]) <- list_exp


df_statistics <- data.frame("Sort_Method"=character(),
                            "Sequence_Size"=character(),
                            "Prob_Fail"=character(),
                            SampleSize=integer(),
                            Num_Sequence_Size=integer(),
                            Num_Prob_Fail=integer(),
                            Mean=numeric(),
                            Min=numeric(),
                            Max=numeric(),
                            Median=numeric(),
                            StdDev=numeric(),
                            stringsAsFactors=FALSE)
df_statistics

for(element_sort in list_sort){
  for(element_n in list_n){
    for(element_exp in list_exp){
      expDB_summary <- subset(expDB, (Sort_Method == element_sort) & (Sequence_Size == element_n) & (Prob_Fail == element_exp) )
      df_statistics[nrow(df_statistics)+1,] = list(element_sort,
                                                   element_n, 
                                                   element_exp,
                                                   nrow(expDB_summary),
                                                   as.integer(element_n), 
                                                   as.integer(element_exp),
                                                   mean(expDB_summary[, 4]),
                                                   min(expDB_summary[, 4]),
                                                   max(expDB_summary[, 4]),
                                                   median(expDB_summary[, 4]),
                                                   round(sd(expDB_summary[, 4]), digits = 2)
      ) 
    }
  }
}

############## Line Charts  
##https://www.statmethods.net/graphs/line.html

Orange <- subset(df_statistics, (Sort_Method == "Quick_Sort"))
s_title = "Quick Sort"

# Create Line Chart

# convert factor to numeric for convenience
#Orange$Tree <- as.numeric(Orange$Tree)
#ntrees <- max(Orange$Tree)
Orange$Tree <- Orange$Num_Prob_Fail
#ntrees <- max(Orange$Num_Prob_Fail)
ntrees <- length(list_exp)

# get the range for the x and y axis
#xrange <- range(Orange$age)
#yrange <- range(Orange$circumference)
xrange <- range(Orange$Num_Sequence_Size)
yrange <- range(Orange$Mean)

# set up the plot
plot(xrange, yrange, type="n", xlab="Sequence Size",
     ylab="Mean of Size Largest Array" )
colors <- rainbow(ntrees)
linetype <- c(1:ntrees)
plotchar <- seq(18,18+ntrees,1)

# add lines
for (i in 1:ntrees) {
  tree <- subset(Orange, (Prob_Fail==list_exp[i]))
  lines(tree$Num_Sequence_Size, tree$Mean, type="b", lwd=1.5,
        lty=linetype[i], col=colors[i], pch=plotchar[i])
}

# add a title and subtitle
#title("Tree Growth", "example of line plot")
title(s_title, "")

# add a legend
legend(xrange[1], yrange[2], list_exp, cex=0.5, col=colors,
       pch=plotchar, lty=linetype, title="Prob of Failure")

