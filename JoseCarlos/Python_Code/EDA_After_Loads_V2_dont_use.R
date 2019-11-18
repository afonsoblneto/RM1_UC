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

# Show data 
#View(expDB) # in a table
print(expDB)

# List column names
names(expDB)
# List the object structure (type and values of each column)
str(expDB)

####################### AGGREGATE ########################
#s_aggr <- aggregate(expDB[, 4], list(expDB$Sort_Method, expDB$Sequence_Size, expDB$Prob_Fail), mean)
#s_aggr <- aggregate(expDB[, 4], list(expDB$Sort_Method, expDB$Sequence_Size), mean)

####################### Subsets ##########################
#s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "1000") & (Prob_Fail == "1.25%") )
#s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "1000")  )
#s1 <- subset(expDB, (Sort_Method == "Bubble_Sort"))
s1


######### Histograms #####
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "1000") & (Prob_Fail == "0.25%") )

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

for(element_sort in list_sort[1]){
  for(element_n in list_n[1:2]){
    par(mfrow=c(2,2))
    for(element_exp in list_exp[1:4]){
      expDB_s1 <- subset(expDB, (Sort_Method == element_sort) & (Sequence_Size == element_n) & (Prob_Fail == element_exp) )
      rf(expDB_s1, paste(element_sort, element_n, element_exp, sep=" / ") )
      rf2(expDB_s1)
      
    }
    par(mfrow=c(1,1))
  }
}


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
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "100")  )
plots[[1]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "500")  )
plots[[2]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "1000")  )
plots[[3]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "2500")  )
plots[[4]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "5000")  )
plots[[5]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "7500")  )
plots[[6]] <- ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Sequence_Size == "10000")  )
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
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort"))
ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Sequence_Size)) + 
  geom_bar(position="dodge", stat="identity")


##### Show Barplots of largest sort array considering sequences sizes for each probability of fail  
library(grid)
library(ggplot2)
plots <- list()
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Prob_Fail == "0.25%")  )
plots[[1]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Prob_Fail == "0.5%")  )
plots[[2]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Prob_Fail == "0.75%")  )
plots[[3]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Prob_Fail == "1%")  )
plots[[4]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Prob_Fail == "1.25%")  )
plots[[5]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Prob_Fail == "1.5%")  )
plots[[6]] <- ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort") & (Prob_Fail == "1.75%")  )
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
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort"))
ggplot(s1, aes(fill=Sequence_Size, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
  geom_bar(position="dodge", stat="identity")


#### All in one plot in one page
library(grid)
library(ggplot2)
plots <- list()
s1 <- subset(expDB, (Sort_Method == "Bubble_Sort"))
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






########################## HISTOGRAMS #################
# Site with several examples os histograms
#   https://www.datamentor.io/r-programming/histogram/

#h <- hist(s1$Size_Larg_Sort_Array)
#text(h$mids,h$counts,labels=h$counts, adj=c(0.5, -0.5))
####################


############### QQ Plot #################
# Link for a youtube video explaining how to interpret qq-plots
##  https://www.youtube.com/watch?v=tdbLShf2bLk

qqnorm(s1$Size_Larg_Sort_Array)
qqline(s1$Size_Larg_Sort_Array)

dev.print(pdf, "D:/GitHub/RM1_UC/JoseCarlos/Python_Code/Statistics.pdf")

############## BoxPlot ###############
boxplot(s1$Size_Larg_Sort_Array, notch = TRUE, col = "grey", ylab = "Size_Larg_Sort_Array", main = "Boxplot of Size_Larg_Sort_Array", boxwex = 0.5, outline = TRUE)


boxplot(s1$Size_Larg_Sort_Array ~ s1$Prob_Fail, notch = TRUE, col = "grey",
        ylab = "Size_Larg_Sort_Array", main = "Boxplot of Size_Larg_Sort_Array by Prob_Fail",
        boxwex = 0.5, varwidth = TRUE)

##############################

# Density estimation -> smoothing of the histogram
library(MASS)
truehist(s1$Size_Larg_Sort_Array, nbins = "FD", col = "grey", prob=TRUE, ylab="Density", main = "Density")
lines(density(s1$Size_Larg_Sort_Array), lwd=2)
lines(density(s1$Size_Larg_Sort_Array, adjust = 0.5), lwd=1)
rug(s1$Size_Larg_Sort_Array)
box()



## Small multiple graphs
#install.packages("viridisLite")
# library
#library(ggplot2)
#library(viridis)
#library(hrbrthemes)

# Graph
#ggplot(s1, aes(fill=Prob_Fail, y=Size_Larg_Sort_Array, x=Prob_Fail)) + 
#  geom_bar(position="dodge", stat="identity") +
#  scale_fill_viridis(discrete = T, option = "E") +
#  ggtitle("Sequence Size") +
#  facet_wrap(~Sequence_Size) +
#  theme_ipsum() +
#  theme(legend.position="none") +
#  xlab("")









#show_statistics <- function(expDB_summary, a_sort, a_n, a_exp) {
show_statistics <- function(expDB_summary) {
  # expDB_summary <- subset(expDB, (Sort_Method == a_sort) & (Sequence_Size == a_n) & (Prob_Fail == a_exp) )
  print(summary(expDB_summary[, 4]))
  cat(paste("Standard Deviation = ", toString(round(sd(expDB_summary[, 4]), digits = 2)), sep = ""), "\n\n")
}

df_statistics <- data.frame("Sort_Method"=character(),
                            "Sequence_Size"=character(),
                            "Prob_Fail"=character(),
                            SampleSize=integer(),
                            Mean=numeric(),
                            Min=numeric(),
                            Max=numeric(),
                            Median=numeric(),
                            StdDev=numeric(),
                              stringsAsFactors=FALSE)
df_statistics

for(element_sort in list_sort){
  #cat("******* SORT METHOD: ", element_sort, "********" , "\n")
  for(element_n in list_n){
    for(element_exp in list_exp){
      #cat(paste("Largert Array Size Statistics for ",element_sort," n = ", element_n, " and Prob_Fail = ", element_exp, sep = ""), "\n")
      expDB_summary <- subset(expDB, (Sort_Method == element_sort) & (Sequence_Size == element_n) & (Prob_Fail == element_exp) )
      #show_statistics(expDB_summary)
      
      df_statistics[nrow(df_statistics)+1,] = list(element_sort,
                                                   element_n, 
                                                   element_exp,
                                                   nrow(expDB_summary),
                                                   mean(expDB_summary[, 4]),
                                                   min(expDB_summary[, 4]),
                                                   max(expDB_summary[, 4]),
                                                   median(expDB_summary[, 4]),
                                                   round(sd(expDB_summary[, 4]), digits = 2)
                                                   ) 
    }
  }
  #cat("****************************************" , "\n\n")
}

options(max.print = 999999999)
sink("D:/GitHub/RM1_UC/JoseCarlos/Python_Code/Statistics.txt", append=FALSE)
print(df_statistics[,])
sink()

# Load ggplot2 library
library(ggplot2)

show_data <- function(field_filter, field_filter_value, field_x_axis, field_y_axis, field_fill ) {
  df2 <- expDB[ which( expDB[,field_filter]==field_filter_value), ]
  print(df2)
  show_graph(df2, field_filter, field_filter_value, field_x_axis, field_y_axis, field_fill )
}


show_graph <- function(df2, field_filter, field_filter_value, field_x_axis, field_y_axis, field_fill ) {
  # Barplot examples extracted in:
  # http://www.sthda.com/english/wiki/ggplot2-barplots-quick-start-guide-r-software-and-data-visualization
  
  #df2 <- expDB[ which( expDB[,field_filter]==field_filter_value), ]
  ggplot(data=df2, aes_string(x=field_x_axis, y=field_y_axis, fill=field_fill)) +
    geom_bar(stat="identity", position=position_dodge())+
    geom_text(aes(label=df2[,field_y_axis]), vjust=1.6, color="white",
              position = position_dodge(0.9), size=3.5)+
    scale_fill_brewer(palette="Paired")+
    theme_minimal()
}

#show_data("Prob_Fail", "1%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
#show_data("Prob_Fail", "2.5%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
#show_data("Prob_Fail", "5%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
#show_data("Prob_Fail", "7.5%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
#show_data("Prob_Fail", "10%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
#show_data("Prob_Fail", "12.5%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
#show_data("Prob_Fail", "15%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")

#show_data("Prob_Fail", "1%", "Sort_Method","Num_Shifts","Sequence_Size")
#show_data("Prob_Fail", "2.5%", "Sort_Method","Num_Shifts","Sequence_Size")
#show_data("Prob_Fail", "5%", "Sort_Method","Num_Shifts","Sequence_Size")
#show_data("Prob_Fail", "7.5%", "Sort_Method","Num_Shifts","Sequence_Size")
#show_data("Prob_Fail", "10%", "Sort_Method","Num_Shifts","Sequence_Size")
#show_data("Prob_Fail", "12.5%", "Sort_Method","Num_Shifts","Sequence_Size")
#show_data("Prob_Fail", "15%", "Sort_Method","Num_Shifts","Sequence_Size")

show_data("Prob_Fail", "0.25%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
show_data("Prob_Fail", "0.5%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
show_data("Prob_Fail", "0.75%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
show_data("Prob_Fail", "1%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
show_data("Prob_Fail", "1.25%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
show_data("Prob_Fail", "1.5%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")
show_data("Prob_Fail", "1.75%", "Sort_Method","Size_Larg_Sort_Array","Sequence_Size")

show_data("Prob_Fail", "0.25%", "Sort_Method","Num_Shifts","Sequence_Size")
show_data("Prob_Fail", "0.5%", "Sort_Method","Num_Shifts","Sequence_Size")
show_data("Prob_Fail", "0.75%", "Sort_Method","Num_Shifts","Sequence_Size")
show_data("Prob_Fail", "1%", "Sort_Method","Num_Shifts","Sequence_Size")
show_data("Prob_Fail", "1.25%", "Sort_Method","Num_Shifts","Sequence_Size")
show_data("Prob_Fail", "1.5%", "Sort_Method","Num_Shifts","Sequence_Size")
show_data("Prob_Fail", "1.75%", "Sort_Method","Num_Shifts","Sequence_Size")


show_data("Sequence_Size", 100, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sequence_Size", 500, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sequence_Size", 1000, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sequence_Size", 2500, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sequence_Size", 5000, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sequence_Size", 7500, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sequence_Size", 10000, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")

show_data("Sequence_Size", 100, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sequence_Size", 500, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sequence_Size", 1000, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sequence_Size", 2500, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sequence_Size", 5000, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sequence_Size", 7500, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sequence_Size", 10000, "Sort_Method","Num_Shifts","Prob_Fail")

#### TO DO #####
# # List simple summary statistics
# summary(expDB[, 4], list(Sequence_Size, Prob_Fail))
# with(expDB, table(Sort_Method, Prob_Fail))
# 
# 
# # It's possible to show the spectific information through functions
# # Mean 
# mean(expDB[, 4])
# # Min
# min(expDB$Na) # or min(expDB[, 1])
# # Max
# max(expDB$Na) # or max(expDB[, 1])
# # Range
# range(expDB$Na) # or range(expDB[, 1])
# # Median
# median(expDB$Na) # or median(expDB[, 1])
