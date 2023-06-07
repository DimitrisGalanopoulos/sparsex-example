#include <stdlib.h>
#include <stdio.h>

#include "spmv_kernel_sparsex.hpp"

int
main()
{
	long m = 5;
	long n = 5;
	long nnz = 13;
	INT_T ia[m+1] = { 0, 3, 5, 8, 11, 13 };
	INT_T ja[nnz] = { 0, 1, 2, 0, 1, 2, 3, 4, 0, 2, 3, 1, 4 };
	ValueType a[nnz] = { 1, -1, -3, -2, 5, 4, 6, 4, -4, 2, 7, 8, -5 };
	ValueType x[n] = { 1, 1, 1, 1, 1 };
	ValueType y[m] = { 0 };
	ValueType y_gold[m] = { 0 };
	long i, j;

	printf("array:\n");
	for (i=0;i<m;i++)
	{
		for (j=ia[i];j<ia[i+1];j++)
		{
			printf("%lf, ", a[j]);
		}
		printf("\n");
	}

	printf("\n");
	printf("test\n");
	for (i=0;i<m;i++)
	{
		for (j=ia[i];j<ia[i+1];j++)
		{
			y_gold[i] += a[j] * x[ja[j]];
		}
	}
	for (i=0;i<m;i++)
	{
		printf("%lf, ", y_gold[i]);
	}
	printf("\n");

	struct CSXArrays M = CSXArrays(ia, ja, a, m, n, nnz);
	M.spmv(x, y);
	for (i=0;i<m;i++)
	{
		printf("%lf, ", y[i]);
	}
	printf("\n");


	return 0;
}


