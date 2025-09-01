#include <stdio.h>
#include <pthread.h>

int mail = 0;
pthread_mutex_t mut;

void *routine(void *args)
{
    for (int i = 0; i < 100000; i++)
    {
        pthread_mutex_lock(&mut);
        mail++;
        pthread_mutex_unlock(&mut);
    }
    return NULL;
}

int main()
{
    pthread_t th[8];
    pthread_mutex_init(&mut, NULL);
    for (int i = 0; i < 8; i++)
    {
        pthread_create(&th[i], NULL, &routine, NULL);
        printf("Thread started no %d\n", i + 1);
    }
    for (int i = 0; i < 8; i++)
    {
        pthread_join(th[i], NULL);
    }
    printf("Value of mail is: %d\n", mail);
    pthread_mutex_destroy(&mut);
    return 0;
}