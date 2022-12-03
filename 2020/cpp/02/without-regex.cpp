#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <algorithm>
#include <chrono>

int is_matching(std::vector<std::string>::const_iterator row) {
  std::string castRow = *row;
  std::vector<std::string> buffer;

  char delimiter = ' ';
  size_t last = 0;
  size_t next = 0;
  for (int i = 0; i < 4; ++i) {
    next = castRow.find(delimiter, last);
    buffer.push_back(castRow.substr(last, next - last));
    last = next + 1;
  }

  char bounds_delimiter = '-';
  short delimiter_position = buffer[0].find(bounds_delimiter);
  short lowest = stoi(buffer[0].substr(0, delimiter_position));
  short highest = stoi(buffer[0].substr(delimiter_position + 1));
  char target = buffer[1][0];
  std::string sequence = buffer[2];

  size_t n = std::count(sequence.begin(), sequence.end(), target);
  if (n >= lowest && n <= highest) {
    return 1;
  } else {
    return 0;
  }
}

int main(int argc, char **argv) {
  std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();

  std::vector<std::string> lines;
  std::ifstream file("input.txt");
  std::string line;
  while (getline(file, line)) {
    lines.push_back(line);
  }

  int count = 0;
  int amount = 0;
  for (std::vector<std::string>::const_iterator i = lines.begin(); i != lines.end(); ++i) {
    int result = is_matching(i);
    amount++;
    if (result == 1) {
      count++;
    }
  }

  std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
  std::cout << "Time difference = " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << "[µs]" << std::endl;
  std::cout << count << "/" << amount << std::endl;
}