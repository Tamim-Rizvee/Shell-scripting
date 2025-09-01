#include <pthread.h>
#include <stdio.h>

void *computation(void *args) // parameters and return types must be void pointers
{
    int x = *(int *)args;
    int sum = 0;
    for (int i = 0; i < 100; i++)
        sum += x;
    printf("%d \n", sum);
    return NULL;
}



int main()
{
    int a = 6  , b =7;
    pthread_t thread1, thread2;
    // pthred_create(name , attributes , fucntion_name , function_arguments(void pointer))
    pthread_create(&thread1, NULL, computation, (void *)&a);
    pthread_create(&thread2, NULL, computation, (void *)&b);

    // to merge the thread with the main thread
    pthread_join(thread1, NULL); // name , returning value
    // the execution will wait in the main thread untill the join happens
    pthread_join(thread2, NULL);
}