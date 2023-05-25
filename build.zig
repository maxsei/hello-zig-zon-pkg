const std = @import("std");

pub fn build(b: *std.Build) void {
    _ = b.addModule(
        "hello",
        .{ .source_file = .{ .path = "./src/main.zig" } },
    );
}
