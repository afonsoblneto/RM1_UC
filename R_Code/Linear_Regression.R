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

Num_Sequence_Size <- expDB[, 2]
expDB <- cbind(expDB, Num_Sequence_Size)
# Changing the col "Sequence_Size" from numerical to categorical
expDB[, 2] <- as.factor(expDB[, 2])
list_n <- c("100","500","1000","2500","5000","7500","10000")
levels(expDB[, 2]) <- list_n
# Show level
levels(expDB[, 2]) 

Num_Prob_Fail <- expDB[, 3]
expDB <- cbind(expDB, Num_Prob_Fail)
# Changing the col "Prob_Fail" from numerical to categorical
expDB[, 3] <- as.factor(expDB[, 3])
# Change the levels of the "Prob_Fail" based on categorical association
list_exp <- c("0.25%","0.5%","0.75%","1%","1.25%","1.5%","1.75%")
levels(expDB[, 3]) <- list_exp
# Show level
levels(expDB[, 3])

# Show data 
#print(expDB)

expDB <- expDB[, -3]
expDB <- expDB[, -2]


# List column names
names(expDB)



# Select subset for ANOVA analysis with 
# Sequence_size = 5000, 7500, 10000
# Prob_Fail = 0.25, 0.75, 1.25
#a_sort="Bubble_Sort"
#a_sort="Insertion_Sort"
#a_sort="Merge_Sort"
a_sort="Quick_Sort"
#expDB_s1 <- subset(expDB, (Sort_Method == a_sort) & +
#                     ((Num_Sequence_Size == 5000)  | +
#                        (Num_Sequence_Size == 7500) | +
#                        (Num_Sequence_Size == 10000)) & + 
#                      ((Num_Prob_Fail == 0.0025) | +
#                        (Num_Prob_Fail == 0.0075) | +
#                        (Num_Prob_Fail == 0.0125)) )

expDB_s1 <- subset(expDB, (Sort_Method == a_sort) & +
                        (Num_Sequence_Size == 10000) & + 
                     ((Num_Prob_Fail == 0.0025) | +
                        (Num_Prob_Fail == 0.0075) | +
                        (Num_Prob_Fail == 0.0125)) )


# Disable scientific notation
options(scipen=999)

expDB_s1 <- expDB_s1[, -1]
expDB_s1 <- expDB_s1[, -2]
#View(expDB_s1)
names(expDB_s1)

cor(expDB_s1)

lr.out = lm(expDB_s1$Size_Larg_Sort_Array ~ expDB_s1$Num_Prob_Fail )
summary(lr.out)
plot(expDB_s1$Size_Larg_Sort_Array ~ expDB_s1$Num_Prob_Fail)
abline(lr.out)
# Use plot function this way and navigate through some graphics (press enter)
#plot(lr.out)


# linear regression with transformation with Exponential model
numTransf <- log(expDB_s1$Size_Larg_Sort_Array)
expDB_s1 <- cbind(expDB_s1, numTransf)
lr.out = lm(numTransf ~ expDB_s1$Num_Prob_Fail)
plot(expDB_s1$numTransf ~ expDB_s1$Num_Prob_Fail)
summary(lr.out)
abline(lr.out)
# Use plot function this way and navigate through some graphics (press enter)
#plot(lr.out)


# linear regression with transformation with Reciprocal model
numTransf <- (1/expDB_s1$Size_Larg_Sort_Array)
expDB_s1 <- cbind(expDB_s1, numTransf)
lr.out = lm(numTransf~expDB_s1$Num_Prob_Fail)
plot(expDB_s1$numTransf~expDB_s1$Num_Prob_Fail)
summary(lr.out)
abline(lr.out)
# Use plot function this way and navigate through some graphics (press enter)
#plot(lr.out)

# linear regression with transformation with Quadratic model
numTransf <- sqrt(expDB_s1$Size_Larg_Sort_Array)
expDB_s1 <- cbind(expDB_s1, numTransf)
lr.out = lm(numTransf~expDB_s1$Num_Prob_Fail)
plot(expDB_s1$numTransf~expDB_s1$Num_Prob_Fail)
summary(lr.out)
abline(lr.out)
# Use plot function this way and navigate through some graphics (press enter)
#plot(lr.out)

# linear regression with transformation with Logarithm model
numTransf <- log(expDB_s1$Num_Prob_Fail)
expDB_s1 <- cbind(expDB_s1, numTransf)
lr.out = lm(expDB_s1$Size_Larg_Sort_Array~numTransf)
plot(expDB_s1$Size_Larg_Sort_Array~numTransf)
summary(lr.out)
abline(lr.out)
# Use plot function this way and navigate through some graphics (press enter)
#plot(lr.out)

