#include <iostream>
#include <vector>

using namespace std;

int main() {
    int n, k, q;
    cin >> n >> k >> q;

    vector<int> step(k);
    vector<int> t(k);
    for (int i = 0; i < k; i++) {
        cin >> step[i] >> t[i];
    }

    vector<int> time(k);
    int sum = t[0];
    for (int i = 0; i < k; i++) {
        if (i == 0) {
            time[i] = step[i] / t[i]; // Corrected calculation for i == 0
        } else {
            time[i] = (step[i] - step[i - 1]) / (t[i] - sum);
        }
        sum += t[i];
    }

    for(int i = 0 ; i < k ;i++){
         cout<<time[i]<<" ";
    }
    cout<<endl;

    while (q--) {
        int a;
        cin >> a;
        int ans = 0;
        for (int i = 0; i < k; i++) {
            if (i == 0 && a < step[i]) {
                ans += a / time[i];
            } else if (i != 0 && a < (step[i] - step[i - 1])) {
                ans += a / time[i];
            } else {
                ans += step[i] / time[i];
                a -= step[i]; // Update a
            }
        }
        // cout << ans << endl;
    }

    return 0;
}
