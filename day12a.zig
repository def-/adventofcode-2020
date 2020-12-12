const std = @import("std");

pub fn abs(x: i32) i32 {
  return std.math.absInt(x) catch unreachable;
}

pub fn main() anyerror!void {
  const content = try std.io.getStdIn().inStream().readAllAlloc(std.testing.allocator, 5000);
  var p = [_]i32{0, 0};
  var d: i32 = 0;
  var lines = std.mem.split(std.mem.trim(u8, content, "\n"), "\n");
  while (lines.next()) |line| {
    const n = std.fmt.parseInt(i32, line[1..], 10) catch unreachable;
    switch (line[0]) {
      'N' => p[1] += n,
      'E' => p[0] += n,
      'S' => p[1] -= n,
      'W' => p[0] -= n,
      'F' =>
        if (d == 0) { p[0] += n; }
        else if (d == 90) { p[1] += n; }
        else if (d == 180) { p[0] -= n; }
        else if (d == 270) { p[1] -= n; },
      'R' => d = @mod(d - n, 360),
      'L' => d = @mod(d + n, 360),
      else => unreachable
    }
  }
  try std.io.getStdOut().outStream().print("{}\n", .{abs(p[0]) + abs(p[1])});
}
