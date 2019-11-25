// Adapted from Rosetta Code


#include <stdlib.h>     
#include <stdio.h>
#include <time.h>
#include <string.h>

#define MAX 10000

int A[MAX], B[MAX];
double eps;

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


double r(){
    return (double)rand() / (double)RAND_MAX ;
}


void merge (int *a, int n, int m) {
    int i, j, k;
    int *x = malloc(n * sizeof (int));
    for (i = 0, j = m, k = 0; k < n; k++) {
        if (r() > eps) {			//no failure
		x[k] = j == n ? a[i++]
             	: i == m      ? a[j++]
             	: a[j] < a[i] ? a[j++]
             	:               a[i++];
    	}
	else {			// failure
		x[k] = j == n ? a[i++]
             	: i == m      ? a[j++]
             	: a[j] >= a[i] ? a[j++]
             	:               a[i++];
    	}
    }
    for (i = 0; i < n; i++) {
        a[i] = x[i];
    }
    free(x);
}
 
void merge_sort (int *a, int n) {
    if (n < 2)
        return;
    int m = n / 2;
    merge_sort(a, m);
    merge_sort(a + m, n - m);
    merge(a, n, m);
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
char* concat(const char *s1, const char *s2, const char *s3, const char *s4)
{
    char *result = malloc(strlen(s1) + strlen(s2) + strlen(s3) + strlen(s4)+ 10); // +1 for the null-terminator
    // in real code you would check for errors in malloc here
    strcpy(result, s1);
    strcat(result, "; ");
    strcat(result, s2);
    strcat(result, "; ");
    strcat(result, s3);
    strcat(result, "; ");
    strcat(result, s4);

    return result;
}


int main() {

        int n, i;

        //Get the experimental data to store: Bubblesort algorithm (1), size of array (n), fault probability (eps),
        //the largest sorted subarray (count) 
        char* dataTostore;
        const char sort_algorithm[12] = "Merge_Sort";

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

        merge_sort(A,n);

        printf("%d",A[0]);
        for (i=1; i<n;i++)
                printf(" %d", A[i]);
        printf("\n");
        
        int count = LNDS(n);

        //Prepare experimental data to store in Database
        //Populate data to store - dataTostore  
        dataTostore = concat(sort_algorithm, integer_to_string(n), double_to_string(eps), integer_to_string(count));
        
        //Store experimental data to store in Database
        store_data(dataTostore);

        eps = -1.0;
        merge_sort(B,n);

        printf("%d",B[0]);
        for (i=1; i<n;i++)
                printf(" %d", B[i]);
        printf("\n%d\n",count);


}





