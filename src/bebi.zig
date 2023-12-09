const std = @import("std");

const bebi = struct {
    buf: [32]u8,
};

// External inline functions
extern fn bebi_add(lhs: *bebi, lhs_size: usize, rhs: *bebi, rhs_size: usize) i32;
extern fn bebi_sub(lhs: *bebi, lhs_size: usize, rhs: *bebi, rhs_size: usize) i32;
extern fn bebi_cmp(lhs: *const bebi, lhs_size: usize, rhs: *const bebi, rhs_size: usize) i32;

extern fn bebi_set_u8(dst: *bebi, offset: usize, val: u8) void;
extern fn bebi_is_zero(bebi: *const bebi, size: usize) bool;
extern fn bebi_get_u8(src: *const bebi, offset: usize) u8;
extern fn bebi_set_u16(dst: *bebi, offset: usize, val: u16) void;
extern fn bebi_get_u16(src: *const bebi, offset: usize) u16;
extern fn bebi_set_u32(dst: *bebi, offset: usize, val: u32) void;
extern fn bebi_get_u32(src: *const bebi, offset: usize) u32;
extern fn bebi_set_u64(dst: *bebi, offset: usize, val: u64) void;
extern fn bebi_get_u64(src: *const bebi, offset: usize) u64;

pub fn bebi32_add(lhs: *bebi, rhs: *bebi) i32 {
    return bebi_add(lhs, 32, rhs, 32);
}

pub fn bebi32_sub(lhs: *bebi, rhs: *bebi) i32 {
    return bebi_sub(lhs, 32, rhs, 32);
}

pub fn bebi32_add_u64(lhs: *bebi, rhs: u64) i32 {
    var rhs_bebi: [8]u8 = undefined;
    bebi_set_u64(&rhs_bebi, 0, rhs);
    return bebi_add(lhs, 32, &rhs_bebi, 8);
}

pub fn bebi32_set_u8(dst: *bebi, val: u8) void {
    std.memset(dst, 0, 32 - 1);
    bebi_set_u8(dst, 32 - 1, val);
}

pub fn bebi32_set_u16(dst: *bebi, val: u16) void {
    std.memset(dst, 0, 32 - 2);
    bebi_set_u16(dst, 32 - 2, val);
}

pub fn bebi32_set_u32(dst: *bebi, val: u32) void {
    std.memset(dst, 0, 32 - 4);
    bebi_set_u32(dst, 32 - 4, val);
}

pub fn bebi32_set_u64(dst: *bebi, val: u64) void {
    std.memset(dst, 0, 32 - 8);
    bebi_set_u64(dst, 32 - 8, val);
}

pub fn bebi32_is_u8(dst: *bebi) bool {
    return bebi_is_zero(dst, 32 - 8);
}

pub fn bebi32_is_u16(dst: *bebi) bool {
    return bebi_is_zero(dst, 32 - 2);
}

pub fn bebi32_is_u32(dst: *bebi) bool {
    return bebi_is_zero(dst, 32 - 4);
}

pub fn bebi32_is_u64(dst: *bebi) bool {
    return bebi_is_zero(dst, 32 - 8);
}

pub fn bebi32_is_u160(dst: *bebi) bool {
    return bebi_is_zero(dst, 32 - 20);
}

pub fn bebi32_get_u16(dst: *bebi) u16 {
    return bebi_get_u16(dst, 32 - 2);
}

pub fn bebi32_get_u32(dst: *bebi) u32 {
    return bebi_get_u32(dst, 32 - 4);
}

pub fn bebi32_get_u64(dst: *bebi) u64 {
    return bebi_get_u64(dst, 32 - 8);
}

pub fn bebi32_is_zero(dst: *bebi) bool {
    return bebi_is_zero(dst, 32);
}

pub fn bebi32_cmp(lhs: *bebi, rhs: *bebi) i32 {
    return bebi_cmp(lhs, 32, rhs, 32);
}

pub fn main() void {
    // You can add your testing code here.
}
