import std.array, std.algorithm, std.range, std.stdio;

void main()
{
  char[][] ns = stdin.byLine().map!(a => "." ~ a ~ ".").array();
  auto empty = '.'.repeat(ns[0].length).array();
  ns = [empty] ~ ns ~ [empty];
  char[][] s = new char[][](ns.length, ns[0].length);
  while (s != ns) {
    foreach (y; 0 .. ns.length) s[y] = ns[y].dup;
    foreach (y; 1 .. s.length - 1)
      foreach (x; 1 .. s[0].length - 1) {
        int c = s[y-1..y+2].map!(n => n[x-1..x+2].map!(a => a == '#').sum).sum;
        ns[y][x] = s[y][x] == 'L' && c == 0 ? '#' : s[y][x] == '#' && c > 4 ? 'L' : s[y][x];
      }
  }
  writeln(ns.map!(n => n.map!(a => a == '#').sum).sum);
}
