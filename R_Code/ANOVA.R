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
a_sort="Bubble_Sort"
#a_sort="Insertion_Sort"
#a_sort="Merge_Sort"
#a_sort="Quick_Sort"
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

# Disable scientific notation
options(scipen=999)

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
qqnorm(aov.out$res, main=paste("Normal Q-Q Plot",a_sort, sep=" - "))
qqline(aov.out$res)

shapiro.test(aov.out$res)

# Test homogeneity of variances
bartlett.test(Size_Larg_Sort_Array~interaction(Sequence_Size,Prob_Fail), data=expDB_s1)

# Tukey HSD
t = TukeyHSD(aov.out,alternative="two.sided")
t$`Sequence_Size:Prob_Fail`[,4]
#write.csv(data.frame(t$`Sequence_Size:Prob_Fail`[,4]), 'D:/GitHub/RM1_UC/R_Code/tukeyresults.csv')

print(t)
plot(t)

Gastropods.ANOVA = aov.out
TukeyHSD(Gastropods.ANOVA)
tuk<-TukeyHSD(Gastropods.ANOVA)
names(tuk)
psig=as.numeric(apply(tuk$`Sequence_Size:Prob_Fail`[,2:3],1,prod)>=0)+1
#op=par(mar=c(4.2,9,3.8,2))
op=par(mai=c(0.5,2.2,0.7,0.2))
plot(tuk,col=psig,yaxt="n")
title(a_sort, line = 1)
for (j in 1:length(psig)){
  axis(2,at=j,labels=paste(((length(psig)-j)+1), rownames(tuk$`Sequence_Size:Prob_Fail`),sep=" - ")[length(psig)-j+1],
       las=1,cex.axis=.8,col.axis=psig[length(psig)-j+1])
}
par(op)

################### Non-parametric Two-Way ANOVA
## Randomization test with unrestricted permutations
D = expDB_s1
aov.out = aov(Size_Larg_Sort_Array~Sequence_Size*Prob_Fail, data=D)
FS = summary(aov.out)[[1]]$F[1]
FP = summary(aov.out)[[1]]$F[2]
FSP = summary(aov.out)[[1]]$F[3]
pvalueS = 0 # p-value for Sequence_Size
pvalueP = 0 # p-value for Prob_Fail
pvalueSP = 0 # p-value for interaction
for (i in 1:5000){
  D$T = sample(D$Size_Larg_Sort_Array)
  aov.out = aov(T~Sequence_Size*Prob_Fail, data=D)
  pFS = summary(aov.out)[[1]]$F[1]
  pFP = summary(aov.out)[[1]]$F[2]
  pFSP = summary(aov.out)[[1]]$F[3]
  if (pFS >= FS)
    pvalueS = pvalueS + 1
  if (pFP >= FP)
    pvalueP = pvalueP + 1
  if (pFSP >= FSP)
    pvalueSP = pvalueSP + 1
}
print( paste("p-value for Sequence_Size:", pvalueS/5000 , sep = " "))
print( paste("p-value for Prob_Fail:", pvalueP/5000 , sep = " "))
print( paste("p-value for interaction:", pvalueSP/5000 , sep = " "))

