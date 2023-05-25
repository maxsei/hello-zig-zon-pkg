const std = @import("std");
const testing = std.testing;

export fn greet() *const [5:0]u8 {
    return "hello";
}

test {
    const ret = greet();
    try std.testing.expectEqualStrings(ret, "hello");
}
