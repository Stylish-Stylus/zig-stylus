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

pub extern "vm_hooks" fn write_result(data: *u64, len: usize) void;

export fn user_entrypoint(len: usize) i32 {
    const input = args(len) catch return 1;
    _ = input;

    var raw_ID: [4]u64 = undefined;
    raw_ID[0] = Hostio.chainid();

    write_result(&raw_ID[0], raw_ID.len);

    return 0;
}
