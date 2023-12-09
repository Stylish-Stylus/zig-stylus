const std = @import("std");

const ArbStatus = enum {
    Success,
    Failure,
};

const ArbResult = struct {
    status: ArbStatus,
    output: [*c]const u8,
    output_len: usize,
};

pub fn revert() void {
    // In Zig, we can use unreachable to indicate an unreachable state
    unreachable;
}
