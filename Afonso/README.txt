
1. Compile the four sorting codes, for instance, in gcc:
  
   gcc quicksort.c -o quick

2. Generate the input sequence to be sorted with the script gen.py in python by
   changing the values of the following variables: 
  - n : sequence size
  - eps : probability of failure
  - maxr : maximum range used by the function "randint"
  The values in the sequence are integers generated according to a (discrete)
  uniform distribution within the interval [1, maxr]. 

3. Run the python code to generate the input for the sorting code as follows:
 
   python gen.py > data.in

4. Run the sorting executable as follows:

   ./quick < data.in > data.out

   In the example above, the output is stored in the file "data.out"



