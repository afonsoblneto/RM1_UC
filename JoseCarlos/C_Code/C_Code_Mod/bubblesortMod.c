 
//Adapted Rosetta Code


#include <stdlib.h>     
#include <stdio.h>
#include <time.h>
#include <string.h>

#define MAX 1000001
#define DATATOSTORE_MAX 5

int A[MAX], B[MAX];

//Changed by JC
int qtd_desloc;
double eps, eps_1;

double r(){
    return (double)rand() / (double)RAND_MAX ;
}

// computes the length of the longest non-decreasing string
//
int LNDS(int n) {

  int max = 1; 
  int len = 1;
  for (int i = 1; i < n; i++) {
    if(A[i-1] <= A[i]) {
        len++;
        if (len > max) 
            max=len;
    } 
    else
        len=1;
  }
  return max;
}



void bubble_sort (int *a, int n) {
    int i, t, j = n, s = 1;
    while (s) {
        s = 0;
        for (i = 1; i < j; i++) {
	  if (r() > eps) {        // no failure  
            if (a[i] < a[i - 1]) {
                t = a[i];
                a[i] = a[i - 1];
                a[i - 1] = t;
                s = 1;
            }
	  }
	  else{			// failure
            if (a[i] >= a[i - 1]) {
                t = a[i];
                a[i] = a[i - 1];
                a[i - 1] = t;
                s = 1;
            }
	  }
        }
        j--;
    }
}

//Store experimental results into database
int store_data( char* data){
    
    FILE *pFile;

    //Open the file
    pFile = fopen("expDB.dat", "a");

    if(pFile==NULL){
        printf ("Could not open the file.\n");
        return 0;
    }

    /* Input data to append */  
   // fputs(data, pFile);  
    fprintf(pFile,"%s\n", data);
    
    /* Reopen file in read mode to print file contents */
    /*fPtr = freopen(filePath, "r", fPtr);
    printf("\nSuccessfully appended data to file. \n");
    printf("Changed file contents:\n\n");
    readFile(fPtr);*/
    
    fclose (pFile);
    
    return 1;
}

//Convert a variable from type integer to string (array of characters)
char* integer_to_string(int x)
{
    char* buffer = malloc(sizeof(char) * sizeof(int) * 4 + 1);
    if (buffer)
    {
         sprintf(buffer, "%d", x);
    }
    return buffer; // caller is expected to invoke free() on this buffer to release memory
}

//Convert a variable from type double to string (array of characters)
char* double_to_string(double x)
{
    char* buffer = malloc(sizeof(char) * sizeof(float) * 4 + 1);
    if (buffer)
    {
         sprintf(buffer, "%lf", x);
    }
    return buffer; // caller is expected to invoke free() on this buffer to release memory
}

//Concatenate strings (arrays of characters)
char* concat(const char *s1, const char *s2, const char *s3, const char *s4, const char *s5)
{
    char *result = malloc(strlen(s1) + strlen(s2) + strlen(s3) + strlen(s4) + strlen(s5) + 10); // +1 for the null-terminator
    
    // in real code you would check for errors in malloc here
    if (result != NULL){
        strcpy(result, s1);
        strcat(result, ", ");
        strcat(result, s2);
        strcat(result, ", ");
        strcat(result, s3);
        strcat(result, ", ");
        strcat(result, s4);
        strcat(result, ", ");
        strcat(result, s5);
    }
    

    return result;
}

//Calcula a quantidade de deslocamentos no Array com memory faults
int calcQtdDesloc(int* A, int* B, int n){

    qtd_desloc = 0;

    if (A!=NULL & B!=NULL){

        for (int i=0; i<n; i++){
            if (A[i] != B[i]){
                qtd_desloc++;
            }
        }     
    }

    return qtd_desloc;

}


int main() {

        int n, i;
                
        //Get the experimental data to store: Bubblesort algorithm (1), size of array (n), fault probability (eps),
        //the largest sorted subarray (count) 
        char* dataTostore;
        const char sort_algorithm[12] = "Bubble_Sort";
                
        scanf("%lf",&eps);
        scanf("%d",&n);

        for (i=0; i < n; i++) 
                scanf("%d",&A[i]);
        srand((unsigned) time(NULL));
        memcpy(B, A, sizeof(A));
        
        printf("%d",A[0]);
        for (i=1; i<n;i++)
                printf(" %d", A[i]);
        printf("\n");

        bubble_sort(A,n);

        printf("%d",A[0]);
        for (i=1; i<n;i++)
                printf(" %d", A[i]);
        printf("\n");

        int count = LNDS(n);

        //Armazena o valor da probabilidade de MF para armazenamento em database       
        eps_1 = eps;        
        eps = -1.0;     
        bubble_sort(B,n);
        
        printf("%d",B[0]);
            for (i=1; i<n;i++)
                printf(" %d", B[i]);
        printf("\n%d\n",count);

        //Calcula a quantidade de deslocamentos no Array com memory faults
        qtd_desloc = calcQtdDesloc(A,B,n);

        //Prepare experimental data to store in Database
        //Populate data to store - dataTostore  
        dataTostore = concat(sort_algorithm, integer_to_string(n), double_to_string(eps_1), 
                                integer_to_string(count), integer_to_string(qtd_desloc));
        
        //Store experimental data to store in Database
        if (dataTostore != NULL){
            store_data(dataTostore);
        }
         
        
	return 0;
}

