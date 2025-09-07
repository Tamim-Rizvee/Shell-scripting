#include<bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0),cin.tie(0),cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;

void compute(int value)
{
    int sum = 0;
    for (int i = 0; i < 1000000000; i++)
        sum += value;
    cout << sum << uwu;
}

int main()
{
    Onii_chan;
    compute(1);
    compute(2);

    return 0;
}