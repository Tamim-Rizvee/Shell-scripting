#include <bits/stdc++.h>
#define Onii_chan ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0)
#define iint long long
#define uwu '\n'
using namespace std;
class process;

map<int, int> ex_log, turn_around_time, waiting_time, completion_time;
ifstream input_file("input.txt");

class process
{
public:
    int id, arrival_time, burst_time;
    process() {}
    process(int id, int at, int bt) : id(id), arrival_time(at), burst_time(bt) {}
    bool operator>(const process &p1) const
    {
        if (this->burst_time > p1.burst_time)
            return true;
        else if (this->burst_time == p1.burst_time)
            return this->id > p1.id;
        return false;
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

void sjf(vector<process> &processes)
{
    int current_time = 0, completed = 0, process_number = processes.size();
    map<int, bool> entered;
    priority_queue<process, vector<process>, greater<process>> ready_queue;
    while (completed < process_number)
    {
        for (int i = 0; i <(int) processes.size(); i++)
        {
            if (processes[i].arrival_time <= current_time && !entered[processes[i].id])
            {
                ready_queue.push(processes[i]);
                entered[processes[i].id] = true;
            }
        }

        if (ready_queue.empty())
        {
            current_time++;
            continue;
        }

        process next_process = ready_queue.top();
        ready_queue.pop();

        ex_log[next_process.id] = current_time;
        current_time += next_process.burst_time;
        completion_time[next_process.id] = current_time;
        turn_around_time[next_process.id] = current_time - next_process.arrival_time;
        waiting_time[next_process.id] = turn_around_time[next_process.id] - next_process.burst_time;
        completed++;
    }
}

int main()
{
    // Onii_chan;
    vector<process> processes;
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

    sjf(processes);

    int process_number = processes.size();

    // Print execution log
    cout << uwu << "\033[34m=== EXECUTION LOG ===\033[0m" << uwu;
    cout << "Process ID -> Start Time" << uwu;
    for (auto entry : ex_log)
    {
        cout << "P" << entry.first << " -> " << entry.second << uwu;
    }

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