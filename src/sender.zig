const std = @import("std");
const WasmAllocator = @import("WasmAllocator.zig");
const Hostio = @import("./Helpers/Hostio.zig");

pub const allocator = std.mem.Allocator{
    .ptr = undefined,
    .vtable = &WasmAllocator.vtable,
};

pub fn args(len: usize) ![]u8 {
    const input = try allocator.alloc(u8, len);
    Hostio.read_args(@as(*u8, @ptrCast(input)));
    return input;
}

pub fn output(data: []u8) void {
    Hostio.write_result(@as(*u8, @ptrCast(data)), data.len);
}

export fn user_entrypoint(len: usize) i32 {
    const input = args(len) catch return 1;
    _ = input;

    var data: [32]u8 = undefined;
    var length: [32]u8 = undefined;

    Hostio.emit_log(&data[0], &length[0]);

    output(&data);
    return 0;
}
