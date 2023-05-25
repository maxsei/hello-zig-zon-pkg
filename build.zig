const std = @import("std");

pub fn build(b: *std.Build) void {
    // Export this file as a "submodule"
    _ = b.addModule(
        "hello",
        .{ .source_file = .{ .path = "./src/hello.zig" } },
    );

    // Tests.
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});
    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/hello.zig" },
        .target = target,
        .optimize = mode,
    });
    const run_main_tests = b.addRunArtifact(main_tests);
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}
