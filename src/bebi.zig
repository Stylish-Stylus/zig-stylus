const std = @import("std");

const bebi = []u8{};

pub fn bebi_set_u8(dst: []u8, offset: usize, val: u8) void {
    dst[offset] = val;
}

pub fn bebi_set_u16(dst: []u8, offset: usize, val: u16) void {
    dst[offset + 1] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset] = @as(u8, @intCast(val & 0xff));
}

pub fn bebi_set_u32(dst: []u8, offset: usize, val: u32) void {
    dst[offset + 3] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset + 2] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset + 1] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset] = @as(u8, @intCast(val & 0xff));
}

pub fn bebi_set_u64(dst: []u8, offset: usize, val: u64) void {
    dst[offset + 7] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset + 6] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset + 5] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset + 4] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset + 3] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset + 2] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset + 1] = @as(u8, @intCast(val & 0xff));
    val >>= 8;
    dst[offset] = @as(u8, @intCast(val & 0xff));
}

pub fn bebi_get_u8(src: []u8, offset: usize) u8 {
    return src[offset];
}

// pub fn bebi_get_u16(src: []u8, offset: usize) u16 {
//     return (u16)src[offset] or ((u16)src[offset + 1] << 8);
// }

// pub fn bebi_get_u32(src: []u8, offset: usize) u32 {
//     return (u32)src[offset] | ((u32)src[offset + 1] << 8) | ((u32)src[offset + 2] << 16) | ((u32)src[offset + 3] << 24);
// }

// pub fn bebi_get_u64(src: []u8, offset: usize) u64 {
//     return (u64)src[offset] | ((u64)src[offset + 1] << 8) | ((u64)src[offset + 2] << 16) | ((u64)src[offset + 3] << 24) |
//            ((u64)src[offset + 4] << 32) | ((u64)src[offset + 5] << 40) | ((u64)src[offset + 6] << 48) | ((u64)src[offset + 7] << 56);
// }

pub fn bebi_add(lhs: []u8, lhs_size: usize, rhs: []u8, rhs_size: usize) i32 {
    if (rhs_size > lhs_size) {
        return -1;
    }
    var left: usize = lhs_size;
    var right: usize = rhs_size;
    var carry: u8 = 0;
    while (left > 0 and right > 0) {
        left -= 1;
        right -= 1;
        const res: u8 = lhs[left] + rhs[right] + carry;

        if (res < lhs[left]) {
            carry = 1;
        } else {
            carry = 0;
        }
        lhs[left] = res;
    }
    while (left > 0 and carry != 0) {
        left -= 1;
        const res: u8 = lhs[left] + carry;
        if (res < lhs[left]) {
            carry = 1;
        } else {
            carry = 0;
        }
        lhs[left] = res;
    }
    return carry;
}

pub fn bebi_sub(lhs: []u8, lhs_size: usize, rhs: []u8, rhs_size: usize) i32 {
    if (rhs_size > lhs_size) {
        return -1;
    }
    var left: usize = lhs_size;
    var right: usize = rhs_size;
    var carry: u8 = 0;
    while (left > 0 and right > 0) {
        left -= 1;
        right -= 1;
        const res: u8 = lhs[left] - rhs[right] - carry;
        if (res < lhs[left]) {
            carry = 1;
        } else {
            carry = 0;
        }
        lhs[left] = res;
    }
    while (left > 0 and carry != 0) {
        left -= 1;
        const res: u8 = lhs[left] - carry;
        if (res < lhs[left]) {
            carry = 1;
        } else {
            carry = 0;
        }
        lhs[left] = res;
    }
    return carry;
}

pub fn bebi_cmp(lhs: []u8, lhs_size: usize, rhs: []u8, rhs_size: usize) i32 {
    var left: usize = 0;
    var right: usize = 0;
    while (lhs_size - left > rhs_size) {
        if (lhs[left] != 0) {
            return 1;
        }
        left += 1;
    }
    while (rhs_size - right > lhs_size) {
        if (rhs[right] != 0) {
            return -1;
        }
        right += 1;
    }
    while (left < lhs_size) {
        if (lhs[left] > rhs[right]) {
            return 1;
        }
        if (lhs[left] < rhs[right]) {
            return -1;
        }
        right += 1;
        left += 1;
    }
    return 0;
}

pub fn bebi_is_zero(input: []u8, size: usize) bool {
    var idx: usize = 0;

    while (idx < size) {
        if (input[idx] != 0) {
            return false;
        }
        idx += 1;
    }
    return true;
}
