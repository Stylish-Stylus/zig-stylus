const std = @import("std");
const WasmAllocator = @import("WasmAllocator.zig");
const Hostio = @import("Hostio.zig");

pub const allocator = std.mem.Allocator{
    .ptr = undefined,
    .vtable = &WasmAllocator.vtable,
};
pub fn result() ![]u8 {
    const result2 = try allocator.alloc(u8, 2);
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

pub extern "vm_hooks" fn account_balance(address: *const u8, dest: *u8) void;

export fn user_entrypoint(len: usize) i32 {
    const input = args(len) catch return 1;

    const address = input[0];

    var dest: u8 = 0;

    account_balance(&address, &dest);
    var result1 = result() catch return 1;

    result1[0] = dest;

    const out = result1[0..result1.len];
    output(out);
    return 0;
}
