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
    printf("Value of mail is: %d\n", mail);
    return NULL;
}

int main()
{
    pthread_t thread1, thread2;
    pthread_mutex_init(&mut, NULL);
    pthread_create(&thread1, NULL, &routine, NULL);
    pthread_create(&thread2, NULL, &routine, NULL);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    pthread_mutex_destroy(&mut);

    return 0;
}