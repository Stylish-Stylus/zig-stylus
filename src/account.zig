const std = @import("std");
const WasmAllocator = @import("WasmAllocator.zig");
const Hostio = @import("./Includes/Hostio.zig");

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

    var address: []u8 = input[0..len];

    var dest: [32]u8 = undefined;

    Hostio.account_balance(&address[0], &dest[0]);

    output(&dest);
    return 0;
}
