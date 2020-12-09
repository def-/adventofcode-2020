#include <iostream>
#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

const int preamble = 25;
std::vector<long> v;

bool find(int i)
{
  for (int j = i - preamble; j < i; j++)
    for (int k = j + 1; k < i; k++)
      if (v[i] == v[j] + v[k])
        return false;
  return true;
}

int main()
{
  std::string l;
  while (std::getline(std::cin, l))
    v.push_back(std::stol(l));
  int i;
  for (i = preamble; i < v.size(); i++)
    if (find(i))
      break;
  std::cout << v[i] << std::endl; // Part 1
  for (int j = 0; j < i; j++)
    for (int k = j + 1; k < i; k++)
      if (v[i] == std::accumulate(&v[j], &v[k+1], 0))
        std::cout << *std::min_element(&v[j], &v[k+1]) + *std::max_element(&v[j], &v[k+1]) << std::endl; // Part 2
}
