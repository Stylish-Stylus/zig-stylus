const std = @import("std");
const WasmAllocator = @import("WasmAllocator.zig");
const Hostio = @import("./Helpers/Hostio.zig");

pub const allocator = std.mem.Allocator{
    .ptr = undefined,
    .vtable = &WasmAllocator.vtable,
};
pub fn result() ![]u8 {
    const result2 = try allocator.alloc(u8, 10);
    return result2;
}

pub fn args(len: usize) ![]u8 {
    const input = try allocator.alloc(u8, len);
    Hostio.read_args(@as(*u8, @ptrCast(input)));
    return input;
}

pub fn output(data: []u8) void {
    Hostio.write_result(@as(*u8, @ptrCast(data)), data.len);
}

// pub extern "vm_hooks" fn account_balance(address: *const u8, dest: *u8) void;

export fn user_entrypoint(len: usize) i32 {
    const input = args(len) catch return 1;

    var address: []u8 = input[0..len];

    var dest: [32]u8 = undefined;

    Hostio.account_balance(&address[0], &dest[0]);

    // var result1 = result() catch return 1;

    // result1[0] = dest;

    // const out = result1[0..result1.len];
    // _ = out;
    output(&dest);
    return 0;
}
