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

    const key = "counter";
    const value: []u8 = input[0..len];
    const comp = "0x03";
    var current_value: [32]u8 = undefined;

    if (value[0] == comp[0]) {
        Hostio.storage_load_bytes32(&key[0], &current_value[0]);
        output(&current_value);
    } else {
        Hostio.storage_store_bytes32(&key[0], &value[0]);
        output(input);
    }

    return 0;
}
