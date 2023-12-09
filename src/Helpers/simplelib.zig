const std = @import("std");

// Importing memcpy and memset functions
extern fn memcpy(dest: *void, src: *const void, count: usize) *void;
extern fn memset(ptr: *void, value: c_int, num: usize) *void;

pub fn strncpy(dst: *u8, src: *const u8, num: usize) *u8 {
    var idx: usize = 0;
    while (idx < num and src[idx] != 0) : (idx += 1) {}

    memcpy(dst, src, idx);
    if (idx < num) {
        memset(dst + idx, 0, num - idx);
    }
    return dst;
}

pub fn strlen(str: *const u8) usize {
    var idx: usize = 0;
    while (str[idx] != 0) : (idx += 1) {}
    return idx;
}
