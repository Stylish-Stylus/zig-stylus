const std = @import("std");
const wasm = @import("wasm");

const PAGE_SIZE: usize = 65536;

var next_free: usize = undefined;
var heap_end: usize = undefined;

pub fn malloc(size: usize) *std.c_void {
    if (size > heap_end - next_free) {
        const pages_required: usize = (size - (heap_end - next_free) + PAGE_SIZE - 1) / PAGE_SIZE;
        const prev_pages: usize = @as(usize, @intCast(wasm.memory.grow(0, pages_required)));
        if (next_free == 0) {
            next_free = prev_pages * PAGE_SIZE;
        }
        heap_end = (prev_pages + pages_required) * PAGE_SIZE;
    }

    const retval: *std.c_void = @as(*std.c_void, @ptrFromInt(next_free));
    next_free += size;
    return retval;
}

// free does nothing
pub fn free(ptr: *std.c_void) void {
    _ = ptr;
}

pub fn main() void {
    // You can add your testing code here.
}
