package main
import ("bufio"; "fmt"; "math"; "os"; "strconv"; "strings")

func main() {
  scanner := bufio.NewScanner(os.Stdin)
  scanner.Scan()
  ts, _ := strconv.Atoi(scanner.Text())
  scanner.Scan()
  bestTs, bestId := math.MaxInt32, 0
  for _, s := range strings.Split(scanner.Text(), ",") {
    if (s == "x") {
      continue
    }
    id, _ := strconv.Atoi(s)
    newTs := (ts / id + 1) * id
    if (ts % id == 0 || newTs < bestTs) {
      bestTs, bestId = newTs, id
    }
  }
  fmt.Println((bestTs - ts) * bestId)
}
