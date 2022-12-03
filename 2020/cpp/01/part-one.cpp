#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <algorithm>
#include <chrono>

int search(std::vector<int> numbers) {
  for (std::vector<int>::iterator i = numbers.begin(); i != numbers.end(); ++i) {
    int number = *i;
    for (std::vector<int>::iterator j = numbers.begin(); j != i; ++j) {
      int comparable = *j;
      if (number + comparable == 2020) {
        return (number * comparable);
      }
    }
  }
  return -1;
}

int main(int argv, char **argc) {
  std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();

  std::vector<int> lines;
  std::ifstream file("input.txt");

  std::string line;
  while (getline(file, line)) {
    int number = stoi(line);
    lines.push_back(number);
  }

  std::sort(lines.begin(), lines.end());

  int result = search(lines);

  std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
  std::cout << "Time difference = " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << "[µs]" << std::endl;
  std::cout << result << std::endl;
}