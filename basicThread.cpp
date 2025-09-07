#include <bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;

void *computation(void *num)
{
    int *number = (int *)num;
    int sum = 0;
    for (int i = 0; i < 1000000000; i++)
    {
        sum += *number;
    }
    cout << sum << uwu;
    return NULL;
}

int main()
{
    Onii_chan;
    pthread_t thread1, thread2;

    int value1 = 1, value2 = 2;

    pthread_create(&thread1, NULL, computation, (void *)&value1);
    pthread_create(&thread2, NULL, computation, (void *)&value2);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    return 0;
}