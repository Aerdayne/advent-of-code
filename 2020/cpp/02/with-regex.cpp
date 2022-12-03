#include <string>
#include <regex>
#include <iostream>
#include <fstream>
#include <algorithm>
#include <chrono>

int is_matching(std::vector<std::string>::const_iterator row, std::regex regexp, std::smatch matches) {
  if (std::regex_search(*row, matches, regexp)) {
    std::string lowest = matches[1].str();
    std::string highest = matches[2].str();
    char target = matches[3].str()[0];
    std::string sequence = matches[4].str();

    size_t n = std::count(sequence.begin(), sequence.end(), target);

    if (n >= stoi(lowest) && n <= std::stoi(highest)) {
      return 1;
    } else {
      return 0;
    }
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

  std::regex regexp("^([0-9]{1,2})-([0-9]{1,2}) ([a-z]): (.*)");
  std::smatch matches;

  int count = 0;
  int amount = 0;
  for (std::vector<std::string>::const_iterator i = lines.begin(); i != lines.end(); ++i) {
    int result = is_matching(i, regexp, matches);

    amount++;
    if (result == 1) {
      count++;
    }
  }

  std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
  std::cout << "Elapsed: " << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() << "µs" << std::endl;
  std::cout << count << "/" << amount << std::endl;
}