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
expDB[, 2] <- as.factor(expDB[, 2])
list_n <- c("100","500","1000","2500","5000","7500","10000")
levels(expDB[, 2]) <- list_n
# Show level
levels(expDB[, 2]) 

# Changing the col "Prob_Fail" from numerical to categorical
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

# Select subset for ANOVA analysis with 
# Sequence_size = 5000, 7500, 10000
# Prob_Fail = 0.25, 0.75, 1.25
#a_sort="Bubble_Sort"
#a_sort="Insertion_Sort"
#a_sort="Merge_Sort"
a_sort="Quick_Sort"
expDB_s1 <- subset(expDB, (Sort_Method == a_sort) & +
                     ((Sequence_Size == "5000")  | +
                        (Sequence_Size == "7500") | +
                        (Sequence_Size == "10000")) & + 
                      ((Prob_Fail == "0.25%") | +
                        (Prob_Fail == "0.75%") | +
                        (Prob_Fail == "1.25%")) )

# Apply only remaing factors
expDB_s1[, 2] <- factor(expDB_s1[, 2])
expDB_s1[, 3] <- factor(expDB_s1[, 3])

#
#View(expDB_s1)

# EDA
boxplot( Size_Larg_Sort_Array ~ Sequence_Size, data=expDB_s1)
boxplot( Size_Larg_Sort_Array ~ Prob_Fail, data=expDB_s1)

interaction.plot(expDB_s1$Sequence_Size, expDB_s1$Prob_Fail,expDB_s1$Size_Larg_Sort_Array)

# Test no interactions, only main effects
aov.out = aov(Size_Larg_Sort_Array~Sequence_Size+Prob_Fail, data=expDB_s1)
summary(aov.out)

# Test interactions and main effects
aov.out = aov(Size_Larg_Sort_Array~Sequence_Size*Prob_Fail, data=expDB_s1)
summary(aov.out)

# Test normality of the residuals
qqnorm(aov.out$res)
qqline(aov.out$res)

shapiro.test(aov.out$res)

# Test homogeneity of variances
bartlett.test(Size_Larg_Sort_Array~interaction(Sequence_Size,Prob_Fail), data=expDB_s1)

# Tukey HSD
t = TukeyHSD(aov.out,alternative="two.sided")
print(t)

