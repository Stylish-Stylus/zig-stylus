const std = @import("std");
const bebi = @import("bebi.zig");
const Hostio = @import("Hostio.zig");

pub fn storage_load(storage: *void, key: *u8, dest: *u8) void {
    _ = storage;
    Hostio.storage_load_bytes32(key, dest);
}

pub fn storage_store(storage: *void, key: *u8, value: *u8) void {
    _ = storage;
    Hostio.storage_store_bytes32(key, value);
}

pub fn array_slot_offset(base: bebi.bebi32, val_size: usize, index: u64, slot_out: bebi.bebi32, offset_out: ?*usize) i32 {
    var slots: u64 = 0;
    var offset: u64 = 0;
    if (val_size == 0) {
        return -1;
    }
    if (val_size >= 32) {
        offset = 0;
        slots = index * ((val_size + 31) / 32);
    } else {
        const per_slot: u64 = 32 / val_size;
        slots = index / per_slot;
        offset = index % per_slot;
    }
    std.memcpy(slot_out.buf, base.buf, 32);
    bebi.bebi32_add_u64(slot_out, slots);
    if (offset_out != null) {
        offset_out.* = @as(usize, @intCast(offset));
    }
    return 0;
}

pub fn dynamic_array_base_slot(storage: bebi.bebi32, base_out: bebi.bebi32) void {
    bebi.native_keccak256(storage.buf, 32, base_out);
}

pub fn map_slot(storage: bebi.bebi32, key: [*]u8, key_len: usize, slot_out: bebi.bebi32) void {
    var buf: [32 + @sizeOf(u8) * key_len]u8 = undefined;
    std.memcpy(buf[0..key_len], key[0..key_len]);
    std.memcpy(buf[key_len..], storage.buf, 32);
    bebi.native_keccak256(buf[0..(32 + key_len)], slot_out);
}
