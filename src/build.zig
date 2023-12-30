const Builder = @import("std").build.Builder;
const bld = Builder;

pub fn build(b: *bld.Builder) void {
    const exe = b.addExecutable("main", "src/main.zig");
    exe.setTarget(.{
        .arch = "wasm32",
        .os = "freestanding",
        .abi = "none",
    });

    exe.setBuildMode(bld.BuildMode.ReleaseSmall);

    // Add any additional configuration here

    // exe.addGlobalLinkSearchPath("./path/to/your/library"); // Adjust the library path as needed

    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("c++");

    const user_entrypoint = exe.addCImport("user_entrypoint", "void");
    user_entrypoint.setCompileMode(bld.CompileMode.LinkObject);

    b.default_step.dependOn(user_entrypoint);

    // b.standardCmd().add("-DZIG_LIB_DIR=\"/path/to/zig\"").run();

    exe.install();

    // exe.run();
}
