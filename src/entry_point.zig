// entrypoint.zig

const std = @import("std");
const hostio = @import("hostio.zig");
const stylus_types = @import("stylus_types.zig");

pub const ENTRYPOINT = fn(user_main: fn(*u8, usize) -> stylus_types.ArbResult) void {
    // Force the compiler to import these symbols
    // Note: calling these functions will unproductively consume gas
    pub fn mark_used() void {
        _ = hostio.memory_grow(0);
    }

    pub fn user_entrypoint(args_len: usize) c_int {
        var args: [args_len]u8 = undefined;
        hostio.read_args(args[0..]);

        var result: stylus_types.ArbResult = user_main(args[0..], args_len);

        hostio.write_result(result.output[0..result.output_len]);
        return result.status;
    }
};
