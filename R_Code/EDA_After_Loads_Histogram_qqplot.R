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
# Show level
levels(expDB[, 1]) 

# Changing the col "Sequence_Size" from numerical to categorical
Num_Sequence_Size <- expDB[, 2]
expDB <- cbind(expDB, Num_Sequence_Size)
expDB[, 2] <- as.factor(expDB[, 2])
list_n <- c("100","500","1000","2500","5000","7500","10000")
levels(expDB[, 2]) <- list_n
# Show level
levels(expDB[, 2]) 

# Changing the col "Prob_Fail" from numerical to categorical
Num_Prob_Fail <- expDB[, 3]
expDB <- cbind(expDB, Num_Prob_Fail)
expDB[, 3] <- as.factor(expDB[, 3])
# Change the levels of the "Prob_Fail" based on categorical association
list_exp <- c("0.25%","0.5%","0.75%","1%","1.25%","1.5%","1.75%")
levels(expDB[, 3]) <- list_exp
# Show level
levels(expDB[, 3])

# Show data 
print(expDB)

# List column names
names(expDB)

######### Histograms #####
# Density estimation -> smoothing of the histogram
library(MASS)

rf <- function(s1_plot, arg_main){
  truehist(s1_plot$Size_Larg_Sort_Array, nbins = "FD", col = "grey", prob=TRUE, ylab="Density", main = arg_main)
  lines(density(s1_plot$Size_Larg_Sort_Array), lwd=2)
  lines(density(s1_plot$Size_Larg_Sort_Array, adjust = 0.5), lwd=1)
  rug(s1_plot$Size_Larg_Sort_Array)
  box()
}

rf2 <- function(s1_plot){
  qqnorm(s1_plot$Size_Larg_Sort_Array)
  qqline(s1_plot$Size_Larg_Sort_Array)
}

### How to combine plots
# https://www.statmethods.net/advgraphs/layout.html

show_hist_qq <- function(arg_sort, arg_seq_size, list_ini, list_end) {
  par(mfrow=c(2,2))
  for(element_exp in list_exp[list_ini:list_end]){
    expDB_s1 <- subset(expDB, (Sort_Method == arg_sort) & (Sequence_Size == arg_seq_size) & (Prob_Fail == element_exp) )
    rf(expDB_s1, paste(arg_sort, arg_seq_size, element_exp, sep=" / ") )
    rf2(expDB_s1)
    
  }
  par(mfrow=c(1,1))
}

#"Insertion_Sort","Merge_Sort","Quick_Sort") 
# How to call this function - one call at a time
aux_sort = "Quick_Sort"
aux_seq_size = "10000"
show_hist_qq(aux_sort,aux_seq_size, 1, 2)
show_hist_qq(aux_sort,aux_seq_size, 3, 4)
show_hist_qq(aux_sort,aux_seq_size, 5, 6)
show_hist_qq(aux_sort,aux_seq_size, 7, 7)

