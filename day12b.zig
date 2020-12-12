const std = @import("std");

pub fn abs(x: i32) i32 {
  return std.math.absInt(x) catch unreachable;
}

pub fn main() anyerror!void {
  const content = try std.io.getStdIn().inStream().readAllAlloc(std.testing.allocator, 5000);
  var p = [_]i32{0, 0};
  var w = [_]i32{10, 1};
  var d: i32 = 0;
  var lines = std.mem.split(std.mem.trim(u8, content, "\n"), "\n");
  while (lines.next()) |line| {
    var n = std.fmt.parseInt(i32, line[1..], 10) catch unreachable;
    switch (line[0]) {
      'N' => w[1] += n,
      'E' => w[0] += n,
      'S' => w[1] -= n,
      'W' => w[0] -= n,
      'F' => {
        p[0] += n * w[0];
        p[1] += n * w[1];
      },
      'R' =>
        while (n > 0) {
          var tmp = w[0];
          w[0] = w[1];
          w[1] = -tmp;
          n -= 90;
        },
      'L' =>
        while (n > 0) {
          var tmp = w[0];
          w[0] = -w[1];
          w[1] = tmp;
          n -= 90;
        },
      else => unreachable
    }
  }
  try std.io.getStdOut().outStream().print("{}\n", .{abs(p[0]) + abs(p[1])});
}
