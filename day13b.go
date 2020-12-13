package main
import ("bufio"; "fmt"; "os"; "strconv"; "strings")

func gcd(a, b int) int {
  for b != 0 {
    a, b = b, a % b
  }
  return a
}

func lcm(a, b int) int {
  return a * b / gcd(a, b)
}

func main() {
  scanner := bufio.NewScanner(os.Stdin)
  scanner.Scan()
  scanner.Scan()
  t, l := 0, 1
  for i, s := range strings.Split(scanner.Text(), ",") {
    if (s == "x") {
      continue
    }
    id, _ := strconv.Atoi(s)
    for ((t + i) % id > 0) {
      t += l
    }
    l = lcm(l, id)
  }
  fmt.Println(t)
}
