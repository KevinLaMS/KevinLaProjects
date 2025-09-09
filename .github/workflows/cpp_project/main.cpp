#include <iostream>

int main() {
    unsigned long long total = 0;
    for (int i = 0; i < 100000000; ++i) {
        total += i;
    }
    std::cout << "C++ total: " << total << std::endl;
    return 0;
}