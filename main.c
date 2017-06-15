#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern void multiply(int* A, int* B, int* result, int lenA, int lenB);
int readToArray(int* array, char input[]);
const int base=10;
const int digitNum= 2000;

int main()
{



    int a[digitNum];
    int b[digitNum];
    int *res;

    char liczba1[digitNum];
    char liczba2[digitNum];


    scanf("%s",liczba1);
    scanf("%s",liczba2);



    int a_size=readToArray(a, liczba1);
    int b_size=readToArray(b, liczba2);

    res = calloc(a_size+b_size, sizeof(int));

   int i;
for(i=0; i<a_size+b_size;i++)
{
     res[i]=0;
}


    multiply(a, b, res, a_size, b_size);


for(i=a_size+b_size-1; i>=0;i--)
{
     printf("%d", res[i]);
}
     printf("\n");
    return 0;
}

/*void multiply(int* A, int* B, int* result, int lenA, int lenB)
{

    int it_a;
    int carry;
    int it_b=0;
    for (;it_b<lenB; it_b++)
    {
        carry=0;
            for (it_a=0;it_a<lenA; it_a++)
        {
            result[it_a + it_b]+= carry + A[it_a]*B[it_b];
            carry = result[it_a + it_b ] / base;
            result[it_a + it_b] %=  base;
        }

        result[it_b + lenA]+=carry;
    }
}*/

int readToArray(int* array, char input[])
{
    int input_size=0;
    do{
        input_size++;
    }while(input[input_size]!=0);
    int i=0;

    for(;i<input_size;i++)
    {
            array[input_size-i-1]=input[i]-'0';
    }
    return input_size;
}
