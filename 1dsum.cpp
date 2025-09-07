#include <bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;

int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
void *calc_sum(void *number)
{
    int value = *(int *)number;
    int *sum = (int *)malloc(sizeof(int));
    *sum = 0;
    for (int i = value; i < value + 3; i++)
    {
        *sum += arr[i];
    }
    return (void *)sum;
}

int main()
{
    Onii_chan;
    pthread_t th[4];
    for (int i = 0; i < 4; i++)
    {
        int *a = (int *)malloc(sizeof(int));
        *a = (12 / 4) * i;
        pthread_create(&th[i], NULL, calc_sum, (void *)a);
    }
    int total = 0;
    int *thread_sum;

    for (int i = 0; i < 4; i++)
    {
        pthread_join(th[i], (void **)&thread_sum);
        total += *thread_sum;
    }
    cout << "Total " << total;
    return 0;
}