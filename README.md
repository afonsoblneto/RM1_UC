# RM1_UC
Source code repository for RM_1_2019 (UC)

To perform this experiment, you should do the following:

1 - Generate input data sample:

	1.1 - go to folder "RM1_UC\Python_Code"
	1.2 - Open the jupyter notebook for python
	1.3 - Open the file gen_v2.ipynb
	1.4 - In the third cell you can change the value of the variable "number_of_samples" if you want an amount different of 50
	1.5 - The python code will generate XX "number_of_samples" files called XX_data.in, where XX ranges from 1 to "number_of_samples"

2 - Run sorting algorithms

	2.1 - Compile and the four sorting source codes, for instance in gcc: 
		gcc bubblesortMod.c -o bubble, 
		gcc insertionsortMod.c -o insertion, 				
		gcc mergesortMod.c -o merge, and 
		gcc quicksortMod.c -o quick
	2.2 - Delete file expDB.dat
	2.3 - After follow the whole step 1, you must run the sorting executables for each sorting algoritm
	2.4 - bubble.exe - for bubble sort
	2.5 - insertion.exe - for insertion sort
	2.6 - merge.exe - for merge sort
	2.7 - quick.exe - for quick sort
	2.8 - A new expDB.dat file will be generated containing the output (sample data set) of the 4 sort methods
	
3 - Perform EDA

	3.1 - go to folder "RM1_UC\R_Code"
	3.2 - To generate bar plot, open the file "EDA_After_Loads_Bar_Plot.R"
	3.3 - In line 2, write the fullpath to the file "expDB.dat"
	3.3 - Run each row in order to see the bar plot
	3.4 - To generate histograms, open the file "EDA_After_Loads_Histogram_qqplot.R"
	3.5 - In line 2, write the fullpath to the file "expDB.dat"
	3.6 - Run each row in order to see the histograms
	3.7 - To generate line plots, open the file "EDA_After_Loads_Line_Plot.R"
	3.8 - In line 2, write the fullpath to the file "expDB.dat"
	3.9 - Run each row in order to see the line plots
	
4 - Perform ANOVA

	4.1 - Open the file "ANOVA.R"
	4.2 - In line 2, write the fullpath to the file "expDB.dat"
	4.3 - In lines 41, 42, 43, and 44 you must uncomment the line correspondent to the sort method to perform ANOVA
	4.4 - Run from line 45 and see ANOVA analysis being performed
	
5 - Perform Linear Regression

	5.1 - Open the file "Linear_Regression.R"
	5.2 - In line 2, write the fullpath to the file "expDB.dat"
	5.3 - In lines 51, 52, 53, and 54 you must uncomment the line correspondent to the sort method to perform linear regression
	5.4 - Run from line 56 and see linear regression being performed
