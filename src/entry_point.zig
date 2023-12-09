const std = @import("std");
const hostio = @import("hostio.zig");
const stylus_types = @import("stylus_types.zig");

pub fn mark_used() void {
    _ = hostio.memory_grow(0);
}

pub fn user_entrypoint(args_len: usize) c_int {
    var args: [args_len]u8 = undefined;
    hostio.read_args(args[0..]);

    var result: stylus_types.ArbResult = undefined;
    // Replace the line below with the actual call to your user_main function
    // result = user_main(args[0..], args_len);

    hostio.write_result(result.output[0..result.output_len]);
    return result.status;
}
