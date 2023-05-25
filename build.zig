const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});

    _ = b.addModule(
        "hello",
        .{ .source_file = .{ .path = "./src/main.zig" } },
    );
}
