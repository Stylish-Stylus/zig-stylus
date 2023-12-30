pub extern "vm_hooks" fn account_balance(address: *u8, dest: *u8) void;

pub extern "vm_hooks" fn account_codehash(address: *u8, dest: *u8) void;

pub extern "vm_hooks" fn storage_store_bytes32(key: *const u8, value: *const u8) void;

pub extern "vm_hooks" fn storage_load_bytes32(key: *const u8, dest: *u8) void;

pub extern "vm_hooks" fn block_basefee(basefee: *u8) void;

pub extern "vm_hooks" fn chainid() u64;

pub extern "vm_hooks" fn block_coinbase(coinbase: *u8) void;

pub extern "vm_hooks" fn block_gas_limit() u64;

pub extern "vm_hooks" fn block_number() u64;

pub extern "vm_hooks" fn block_timestamp() u64;

pub extern "vm_hooks" fn call_contract(contract: *u8, calldata: *u8, calldata_len: usize, value: *u8, value: *u8, gas: *u64, return_data_len: *usize) u8;

pub extern "vm_hooks" fn contract_address(address: *u8) void;

pub extern "vm_hooks" fn create1(code: *u8, code_len: usize, endowment: *u8, contract: *u8, revert_data_len: *usize) void;

pub extern "vm_hooks" fn create2(code: *u8, code_len: usize, endowment: *u8, salt: *u8, contract: *u8, revert_data_len: *usize) void;

pub extern "vm_hooks" fn delegate_call_contract(contract: *u8, calldata: *u8, calldata_len: usize, gas: *u64, return_data_len: *usize) u8;

pub extern "vm_hooks" fn emit_log(data: *u8, len: usize, topics: usize) void;

pub extern "vm_hooks" fn evm_gas_left() u64;

pub extern "vm_hooks" fn evm_ink_left() u64;

pub extern "vm_hooks" fn memory_grow(pages: *u8) void;

pub extern "vm_hooks" fn msg_sender(sender: *u8) void;

pub extern "vm_hooks" fn msg_value(value: *u8) void;

pub extern "vm_hooks" fn native_keccak256(bytes: *u8, len: usize, output: *u8) void;

pub extern "vm_hooks" fn read_args(data: *u8) void;

pub extern "vm_hooks" fn read_return_data(dest: *u8, offset: usize, size: usize) void;

pub extern "vm_hooks" fn write_result(data: *u8, len: usize) void;

pub extern "vm_hooks" fn return_data_size() usize;

pub extern "vm_hooks" fn static_call_contract(contract: *u8, calldata: *u8, calldata_len: usize, gas: u64, return_data_len: *usize) u8;

pub extern "vm_hooks" fn tx_gas_price(gas_price: *u8) void;

pub extern "vm_hooks" fn tx_ink_price() u64;

pub extern "vm_hooks" fn tx_origin(origin: *u8) void;
