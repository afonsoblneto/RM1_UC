// Adapted from Rosetta Code.
 
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


void insertion_sort(int *a, int n) {
	for(size_t i = 1; i < n; ++i) {
		int tmp = a[i];
		size_t j = i;
		while(j > 0) {
			if (r() > eps){		//no failure
				if (tmp >= a[j-1])
					break;
			}
			else {			//failure
				if (tmp < a[j-1])
					break;
			}
			a[j] = a[j - 1];
			--j;
		}
		a[j] = tmp;
	}
}


int main() {

        int n, i;

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


        insertion_sort(A,n);

        printf("%d",A[0]);
        for (i=1; i<n;i++)
                printf(" %d", A[i]);
        printf("\n");
       	int count = LNDS(n);

	eps = -1.0;

        insertion_sort(B,n);

        printf("%d",B[0]);
        for (i=1; i<n;i++)
                printf(" %d", B[i]);
        printf("\n%d\n",count);


}




