#include <bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;
class process;

unordered_map<int, int> turn_around_time, waiting_time, completion_time;
ifstream input_file("input.txt");

class process
{
public:
    int id, arrival_time, burst_time, remaining_time;
    process() {}
    process(int id, int at, int bt, int rt = 0)
    {
        this->id = id;
        this->arrival_time = at;
        this->burst_time = bt;
        this->remaining_time = (rt == 0 ? bt : rt);
    }
};
void make_arr(string input, vector<process> &processes)
{
    string pro;
    vector<string> times;
    istringstream iss(input);
    while (iss >> pro)
        times.push_back(pro);

    if (times.size() >= 3)
    {
        int id = atoi(times[0].c_str());
        int at = atoi(times[1].c_str());
        int bt = atoi(times[2].c_str());
        processes.push_back(process(id, at, bt));
    }
}

void round_robin(vector<process> &processes, int quantum_time)
{
    int current_time = 0, completed = 0, process_number = processes.size();
    map<int, bool> entered;
    deque<process> ready_queue;
    process push(0, 0, 0);
    while (completed < process_number)
    {
        for (auto x : processes)
        {
            if (x.arrival_time <= current_time && !entered[x.id])
            {
                ready_queue.push_back(x);
                entered[x.id] = true;
            }
        }

        if(push.id != 0)
            ready_queue.push_back(push);

        if (ready_queue.empty())
        {
            current_time++;
            continue;
        }

        process next_process = ready_queue.front();
        ready_queue.pop_front();

        int id = next_process.id;
        int at = next_process.arrival_time;
        int bt = next_process.burst_time;
        int rt = next_process.remaining_time;

        if (rt >= quantum_time)
        {
            rt -= quantum_time;
            current_time += quantum_time;
        }
        else
        {
            current_time += rt;
            rt = 0;
        }

        if (rt == 0)
        {
            int ct = current_time;
            int tat = ct - at;
            int wt = tat - bt;

            completion_time[id] = ct;
            turn_around_time[id] = tat;
            waiting_time[id] = wt;

            completed++;
            push = process(0, 0, 0);
            continue;
        }
        push = process(id, at, bt, rt);
    }
}

int main()
{
    Onii_chan;
    vector<process> processes;
    int quantum_time = 2;
    string line;
    while (getline(input_file, line))
    {
        if (!line.empty())
        {
            make_arr(line, processes);
        }
    }
    input_file.close();

    if (processes.empty())
    {
        cout << "No processes found in input file!" << uwu;
        return 1;
    }

    round_robin(processes, quantum_time);

    int process_number = processes.size();
    // Print comprehensive table
    cout << uwu << "=== PROCESS SCHEDULING TABLE ===" << uwu;
    cout << "+-----------+----+----+------+------+------+" << uwu;
    cout << "| Process   | AT | BT | CT   | TAT  | WT   |" << uwu;
    cout << "| ID        |    |    |      |      |      |" << uwu;
    cout << "+-----------+----+----+------+------+------+" << uwu;

    for (int i = 0; i < process_number; i++)
    {
        int pid = processes[i].id;
        cout << "| P" << setw(8) << pid << " | "
             << setw(2) << processes[i].arrival_time << " | "
             << setw(2) << processes[i].burst_time << " | "
             << setw(4) << completion_time[pid] << " | "
             << setw(4) << turn_around_time[pid] << " | "
             << setw(4) << waiting_time[pid] << " |" << uwu;
    }
    cout << "+-----------+----+----+------+------+------+" << uwu;

    // Calculate and print averages
    double avg_turnaround = 0, avg_waiting = 0;
    for (int i = 0; i < process_number; i++)
    {
        avg_turnaround += turn_around_time[processes[i].id];
        avg_waiting += waiting_time[processes[i].id];
    }
    avg_turnaround /= process_number;
    avg_waiting /= process_number;

    cout << uwu << "=== AVERAGES ===" << uwu;
    cout << "Average Turnaround Time: " << fixed << setprecision(2) << avg_turnaround << uwu;
    cout << "Average Waiting Time: " << fixed << setprecision(2) << avg_waiting << uwu;

    return 0;
}