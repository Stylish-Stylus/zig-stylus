# Zig Stylus

Zig Stylus is an Arbitrum Stylus SDK for the Zig programming language, designed for writing WebAssembly (WASM) smart contracts. It offers a concise and minimal syntax for those who prefer not to use Rust, providing an alternative for developing Zig smart contracts on the Arbitrum Stylus platform.

**Note: This library is still in development and not mature enough for production use.**

# Installation

1. Install Cargo Stylus CLI:

    ```bash
    cargo install cargo-stylus
    ```

2. Install Foundary Cast for calling deployed contracts:

    ```bash
    curl -L https://foundry.paradigm.xyz | bash
    ```

3. Clone the Repository

    ```bash
    git clone https://github.com/Stylish-Stylus/zig-stylus.git
    cd zig-stylus
    ```

4. Build your Contract

    ```bash
    zig build-lib ./src/main.zig -target wasm32-freestanding -dynamic --export=user_entrypoint -OReleaseSmall
    ```
5. Check Deployment Compatibility
    
    ```bash
    cargo stylus check --wasm-file-path main.wasm
    ```
6. Deploy to Arbitrum Stylus

    ```bash
    cargo stylus deploy --wasm-file-path chainid.wasm --private-key <private-key>
    ```
7. Call Contract Entry Point

    ```bash
    ./cast call --rpc-url 'https://stylus-testnet.arbitrum.io/rpc' <contract-id> <input>
    ```
