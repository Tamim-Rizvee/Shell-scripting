#include <bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;

int mail = 0;
pthread_mutex_t mut;
void *routine(void *args)
{
    for (int i = 0; i < 1000000; i++)
    {
        pthread_mutex_lock(&mut);
        mail++;
        pthread_mutex_unlock(&mut);
    }

    return NULL;
}

int main()
{
    Onii_chan;
    pthread_t thread1, thread2;
    pthread_mutex_init(&mut, NULL);

    pthread_create(&thread1, NULL, routine, NULL);
    pthread_create(&thread2, NULL, routine, NULL);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    pthread_mutex_destroy(&mut);

    cout << mail << uwu;
    return 0;
}