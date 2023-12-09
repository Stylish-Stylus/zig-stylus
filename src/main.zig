const std = @import("std");
const WasmAllocator = @import("WasmAllocator.zig");

pub extern "vm_hooks" fn read_args(dest: *u8) void;
pub extern "vm_hooks" fn write_result(data: *const u8, len: usize) void;

pub const allocator = std.mem.Allocator{
    .ptr = undefined,
    .vtable = &WasmAllocator.vtable,
};

pub fn args(len: usize) ![]u8 {
    const input = try allocator.alloc(u8, len);
    read_args(@as(*u8, @ptrCast(input)));
    return input;
}

pub fn output(data: []u8) void {
    write_result(@as(*u8, @ptrCast(data)), data.len);
}

export fn user_entrypoint(len: usize) i32 {
    var input = args(len) catch return 1;
    const out = input[0..1];
    output(out);
    return 0;
}
