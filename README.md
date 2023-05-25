# hello-zig-zon-pkg

This is just a way for myself to test out and document [`build.zig.zon`](https://github.com/ziglang/zig/issues/14290) style dependency management. [This repository](https://github.com/maxsei/use-hello-zig-zon-pkg) is a zig project that depends on this repository as a dependency.

A dependency in `build.zig.zon` system is effectively a namespace that's defined in the `build.zig` file, mapping arbitrary names to sources files (and other sources files they import).
```zig
// build.zig
// ...
pub fn build(b: *std.Build) void {
    _ = b.addModule(
        "mymodulename",
        .{ .source_file = .{ .path = "./src/hello.zig" } },
    );
}
// ...
```

A zig project can refer to a remote dependency with an arbitrary field name in the `.dependencies` field of `build.zig.zon`.

<details>
<summary>
  <code>build.zig.zon</code>
</summary>
<br>

https://github.com/maxsei/use-hello-zig-zon-pkg/blob/b20efee8b4469f64e37f3498611ea93fed9497f7/build.zig.zon

```zig
.{
    .name = "jomammad",
    .version = "0.1.0",
    .dependencies = .{
        .hello = .{
            .url  = "https://github.com/maxsei/hello-zig-zon-pkg/archive/7b8f7278265a14e6879dd974bfe063a664524cb8.tar.gz",
            .hash = "1220aa2cf330fb36da40119277f3d99e979e2bf8bc5042cec1aaff067e4c669bfa4f",
        },
    },
}
```
</details>

and can be included in `build.zig` with:

```zig
    // ...
    const hello = b.dependency("hello", .{});
    // ...
```

From there a dependency's modules can be included in zig build artifacts

```zig
    exe.addModule("mymodulename", hello.module("hello"));
    b.installArtifact(exe);
```

And imported via
```zig
@import("mymodulename")
```
