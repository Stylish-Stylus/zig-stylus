const std = @import("std");

const bebi = @import("bebi.zig");

const ARB_SUCCESS: u32 = 0x00000000;
const ARB_FAILURE: u32 = 0x08c379a0;

pub fn msg_sender_padded(sender: bebi.bebi) void {
    // Implementation of msg_sender_padded
    bebi.msg_sender(sender + 12);
}

pub fn _return_nodata(status: u32) bebi.ArbResult {
    return bebi.ArbResult{ status, null, 0 };
}

pub fn _return_short_string(status: u32, string: [*]u8) bebi.ArbResult {
    var buf_out: [100]u8 = undefined;
    var len: usize = std.mem.strlen(string);
    if (len > 32) {
        len = 32;
    }

    const strlen_out: bebi.bebi32 = undefined;
    var str_out: [32]u8 = undefined;

    bebi.bebi32_set_u64(strlen_out, @as(u64, @intCast(len)));
    std.mem.memcpy(str_out[0..len], string[0..len]);

    // Tuple encoding: offset, strlen, str
    bebi.bebi32_set_u64(buf_out[4..], 32);

    if (status == ARB_FAILURE) {
        // Err encoding: ErrSignature
        bebi.bebi_set_u32(buf_out, 0, ARB_FAILURE);
        return bebi.ArbResult{ ARB_FAILURE, buf_out[0..], 100 };
    }

    return bebi.ArbResult{ ARB_SUCCESS, buf_out[4..], 96 };
}
