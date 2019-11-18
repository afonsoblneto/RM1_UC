# Load data file
expDB <- read.csv("D:/GitHub/RM1_UC/JoseCarlos/Python_Code/expDB.dat", header=FALSE)

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


aux_sort <- "Quick_Sort"

################# How to save multiple plots in one page ######
### http://rstudio-pubs-static.s3.amazonaws.com/2852_379274d7c5734f979e106dcf019ec46c.html
##
# Site with several examples barcharts with ggplot
#   https://www.r-graph-gallery.com/48-grouped-barplot-with-ggplot2.html
# Load ggplot2 library

##### Show Barplots of largest sort array considering probabilities of fail for each sequence size 
library(grid)
library(ggplot2)
plots <- list()
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Sequence_Size == "100")  )
plots[[1]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Sequence_Size == "500")  )
plots[[2]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Sequence_Size == "1000")  )
plots[[3]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Sequence_Size == "2500")  )
plots[[4]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Sequence_Size == "5000")  )
plots[[5]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Sequence_Size == "7500")  )
plots[[6]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Sequence_Size == "10000")  )
plots[[7]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")

grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 2)))
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
print(plots[[1]], vp = vplayout(1, 1))  # key is to define vplayout
print(plots[[2]], vp = vplayout(1, 2))
print(plots[[3]], vp = vplayout(2, 1))  # key is to define vplayout
print(plots[[4]], vp = vplayout(2, 2))
print(plots[[5]], vp = vplayout(3, 1))  # key is to define vplayout
print(plots[[6]], vp = vplayout(3, 2))
print(plots[[7]], vp = vplayout(4, 1))  # key is to define vplayout


#### All in one plot
s1 <- subset(expDB, (Sort_Method == aux_sort))
ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")


##### Show Barplots of largest sort array considering sequences sizes for each probability of fail  
library(grid)
library(ggplot2)
plots <- list()
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Prob_Fail == "0.25%")  )
plots[[1]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Prob_Fail == "0.5%")  )
plots[[2]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Prob_Fail == "0.75%")  )
plots[[3]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Prob_Fail == "1%")  )
plots[[4]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Prob_Fail == "1.25%")  )
plots[[5]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Prob_Fail == "1.5%")  )
plots[[6]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == aux_sort) & (Prob_Fail == "1.75%")  )
plots[[7]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")


grid.newpage()
pushViewport(viewport(layout = grid.layout(4, 2)))
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
print(plots[[1]], vp = vplayout(1, 1))  # key is to define vplayout
print(plots[[2]], vp = vplayout(1, 2))
print(plots[[3]], vp = vplayout(2, 1))  # key is to define vplayout
print(plots[[4]], vp = vplayout(2, 2))
print(plots[[5]], vp = vplayout(3, 1))  # key is to define vplayout
print(plots[[6]], vp = vplayout(3, 2))
print(plots[[7]], vp = vplayout(4, 1))  # key is to define vplayout

#### All in one plot
s1 <- subset(expDB, (Sort_Method == aux_sort))
ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")


#### All in one plot in one page
library(grid)
library(ggplot2)
plots <- list()
s1 <- subset(expDB, (Sort_Method == aux_sort))
plots[[1]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
plots[[2]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 1)))
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
print(plots[[1]], vp = vplayout(1, 1))  # key is to define vplayout
print(plots[[2]], vp = vplayout(2, 1))

####################
