// Trabalho 1 Organização e Arquitetura de Processadores
// Thiago Zilberknop, Leonardo Chou da Rosa

#include <iostream>

using namespace std;

int funcAckermann(int m, int n) {
    if (m == 0) {
        return n + 1;
    }
    if (m > 0 && n == 0) {
        return funcAckermann(m - 1, 1);
    }
    if (m > 0 && n > 0) {
        return funcAckermann(m-1, funcAckermann(m, n-1));
    }
    return 0;
}

int main () {
    int m = 0;
    int n = 0;
    cout << "Digite m: ";
    cin >> m;
    cout << "Digite n: ";
    cin >> n;
    cout << endl;
    cout << "A(" << m << "," << n << ")" << " = " << funcAckermann(m, n) << endl;
}