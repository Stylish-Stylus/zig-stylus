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
    _ = input;

    const key = "counter";
    const flag = "is_intialized";
    var is_initialized: u8 = 0;

    Hostio.storage_load_bytes32(&flag[0], &is_initialized);

    if (is_initialized == 0) {
        const initial_count: u8 = 1;
        const intialized: u8 = 1;

        Hostio.storage_store_bytes32(&key[0], &initial_count);
        Hostio.storage_store_bytes32(&flag[0], &intialized);

        var ain: [1]u8 = undefined;
        ain[0] = is_initialized;

        output(&ain);

        return 0;
    } else {

        // counter current value
        var current_value: u8 = 0;
        Hostio.storage_load_bytes32(&key[0], &current_value);

        var increment_value: u8 = current_value + 1;

        // increment the value
        Hostio.storage_store_bytes32(&key[0], &increment_value);
    }

    var current_value: [1]u8 = undefined;
    Hostio.storage_load_bytes32(&key[0], &current_value[0]);

    output(&current_value);

    return 0;
}
