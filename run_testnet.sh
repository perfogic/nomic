pm2 delete all
# rm -r /home/lenovo/.oraibtc-local-3
nomic set-signatory-key --chain-id oraibtc-local-3
pm2 start "FUNDED_ADDRESS=nomic1rchnkdpsxzhquu63y6r4j4t57pnc9w8ecxjqll FUNDED_ORAIBTC_AMOUNT=100000000000 nomic start --chain-id oraibtc-local-3"
pm2 start "nomic signer --chain-id oraibtc-local-3"
pm2 start "nomic relayer --rpc-port=18332 --rpc-user=satoshi --rpc-pass=nakamoto --chain-id oraibtc-local-3"
pm2 start "bitcoind -server -testnet -rpcuser=satoshi -rpcpassword=nakamoto -prune=5000 -datadir=/media/lenovo/DATABOX/Developer/.bitcoin-testnet"
pm2 start "nomic grpc --chain-id oraibtc-local-3 -- 9001"

# nomic declare I8IvUXEzu7AqPVHdjqVTBtnEKlmkx7eMKKUCA6uflhA=" 10000000000 0.042 0.1 0.01 10000000000 "Foo Bar" "Foo Bar" JASDHKAJSD "Foo Bar"
# RUST_LOG=info cargo test --verbose --test bitcoin --features=full,feat-ibc,testnet,faucet-test,devnet --jobs 4 -- --ignored