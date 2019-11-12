# Load data file
expDB <- read.csv("D:/GitHub/RM1_UC/JoseCarlos/Python_Code/expDB.dat", header=FALSE)

# Naming columns
colnames(expDB) <- c("Sort_Method", "Sample_Size", "Prob_Fail", "Size_Larg_Sort_Array", "Num_Shifts")

# Changing the col "Sort_Method" to categorical
expDB[, 1] <- as.factor(expDB[, 1])
# Show level
levels(expDB[, 1]) 

# Changing the col "Sample_Size" from numerical to categorical
expDB[, 2] <- as.factor(expDB[, 2])
# Show level
levels(expDB[, 2]) 

# Changing the col "Prob_Fail" from numerical to categorical
expDB[, 3] <- as.factor(expDB[, 3])
# Change the levels of the "Prob_Fail" based on categorical association
levels(expDB[, 3]) <- c("1%","2.5%","5%","7.5%","10%","12.5%","15%")
# Show level
levels(expDB[, 3])

# Show data 
#View(expDB) # in a table
print(expDB)

# Export dataframe
#write.csv(expDB,"D:/GitHub/RM1_UC/JoseCarlos/Python_Code/data_exp.csv", row.names = TRUE)

# List column names
names(expDB)
# List the object structure (type and values of each column)
str(expDB)

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

show_data("Prob_Fail", "1%", "Sort_Method","Size_Larg_Sort_Array","Sample_Size")
show_data("Prob_Fail", "2.5%", "Sort_Method","Size_Larg_Sort_Array","Sample_Size")
show_data("Prob_Fail", "5%", "Sort_Method","Size_Larg_Sort_Array","Sample_Size")
show_data("Prob_Fail", "7.5%", "Sort_Method","Size_Larg_Sort_Array","Sample_Size")
show_data("Prob_Fail", "10%", "Sort_Method","Size_Larg_Sort_Array","Sample_Size")
show_data("Prob_Fail", "12.5%", "Sort_Method","Size_Larg_Sort_Array","Sample_Size")
show_data("Prob_Fail", "15%", "Sort_Method","Size_Larg_Sort_Array","Sample_Size")

show_data("Prob_Fail", "1%", "Sort_Method","Num_Shifts","Sample_Size")
show_data("Prob_Fail", "2.5%", "Sort_Method","Num_Shifts","Sample_Size")
show_data("Prob_Fail", "5%", "Sort_Method","Num_Shifts","Sample_Size")
show_data("Prob_Fail", "7.5%", "Sort_Method","Num_Shifts","Sample_Size")
show_data("Prob_Fail", "10%", "Sort_Method","Num_Shifts","Sample_Size")
show_data("Prob_Fail", "12.5%", "Sort_Method","Num_Shifts","Sample_Size")
show_data("Prob_Fail", "15%", "Sort_Method","Num_Shifts","Sample_Size")

show_data("Sample_Size", 100, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sample_Size", 1000, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sample_Size", 2500, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sample_Size", 5000, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sample_Size", 7500, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")
show_data("Sample_Size", 10000, "Sort_Method","Size_Larg_Sort_Array","Prob_Fail")

show_data("Sample_Size", 100, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sample_Size", 1000, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sample_Size", 2500, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sample_Size", 5000, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sample_Size", 7500, "Sort_Method","Num_Shifts","Prob_Fail")
show_data("Sample_Size", 10000, "Sort_Method","Num_Shifts","Prob_Fail")

#### TO DO #####
# # List simple summary statistics
# summary(expDB[, 4], list(Sample_Size, Prob_Fail))
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
