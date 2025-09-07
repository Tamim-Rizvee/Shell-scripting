#include <bits/stdc++.h>
#include <pthread.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;

int arr1[3][3] = {{1, 2, 3},
                  {4, 5, 6},
                  {7, 8, 9}};
int arr2[3][3] = {{9, 8, 7},
                  {6, 5, 4},
                  {3, 2, 1}};
int result[3][3];

void *matrix_sum(void *number)
{
    int i = *(int *)number;
    for (int m = 0; m < 3; m++)
    {
        result[i][m] = arr1[i][m] + arr2[i][m];
    }

    return NULL;
}

int main()
{
    Onii_chan;

    pthread_t th[3];
    int thread_args[3];
    for (int i = 0; i < 3; i++)
    {
        thread_args[i] = i; 
        pthread_create(&th[i], NULL, matrix_sum, (void *)&thread_args[i]);
    }

    for (int i = 0; i < 3; i++)
    {
        pthread_join(th[i], NULL);
    }
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            cout << result[i][j] << " ";
        }
        cout << uwu;
    }
    return 0;
}