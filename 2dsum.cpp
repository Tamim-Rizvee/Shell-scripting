#include <bits/stdc++.h>
#include <pthread.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;

void *calc_sum(void *array)
{
    int *arr = (int *)array;
    int n = 3;
    int *sum = (int *)malloc(sizeof(int));
    *sum = 0;
    for (int i = 0; i < n; i++)
    {
        *sum += arr[i];
    }
    return (void *)sum;
}

int main()
{
    Onii_chan;
    int arr[4][3] = {{1, 2, 3},
                     {4, 5, 6},
                     {7, 8, 9},
                     {10, 11, 12}};

    pthread_t th[4];
    for (int i = 0; i < 4; i++)
    {
        pthread_create(&th[i], NULL, calc_sum, (void *)arr[i]);
    }
    int total = 0;
    int *thread_sum;

    for (int i = 0; i < 4; i++)
    {
        pthread_join(th[i], (void **)&thread_sum);
        total += *thread_sum;
        free(thread_sum); 
    }
    cout << "total = " << total << uwu;
    return 0;
}