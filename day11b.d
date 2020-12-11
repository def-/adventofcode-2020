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
        int c = 0;
        foreach (dy; -1..2)
          foreach (dx; -1..2)
            if (dx != 0 || dy != 0)
              for (ulong ny = y + dy, nx = x + dx; ny >= 0 && ny < s.length && nx >= 0 && nx < s[0].length; ny += dy, nx += dx) {
                if (s[ny][nx] == 'L') break;
                if (s[ny][nx] == '#') { c++; break; }
              }
        ns[y][x] = s[y][x] == 'L' && c == 0 ? '#' : s[y][x] == '#' && c > 4 ? 'L' : s[y][x];
      }
  }
  writeln(ns.map!(n => n.map!(a => a == '#').sum).sum);
}
