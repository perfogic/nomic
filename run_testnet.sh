pm2 delete all
# rm -r /home/lenovo/.oraibtc-local-2
nomic set-signatory-key --chain-id oraibtc-local-2
pm2 start "FUNDED_ADDRESS=nomic1rchnkdpsxzhquu63y6r4j4t57pnc9w8ecxjqll FUNDED_ORAIBTC_AMOUNT=100000000000  FUNDED_USAT_AMOUNT=0 nomic start --chain-id oraibtc-local-2"
pm2 start "nomic signer --chain-id oraibtc-local-2"
pm2 start "nomic relayer --rpc-port=18332 --rpc-user=satoshi --rpc-pass=nakamoto --chain-id oraibtc-local-2"
pm2 start "bitcoind -server -testnet -rpcuser=satoshi -rpcpassword=nakamoto -prune=5000 -datadir=/media/lenovo/DATABOX/Developer/.bitcoin-testnet"
pm2 start "nomic grpc --chain-id oraibtc-local-2 -- 9001"

# nomic declare HoCvuOoT4bifF/Ac80lo8v9Pd/LqVF9Ppaq7PMi0Q8A= 10 0.042 0.1 0.01 10 "Foo Bar" "Foo Bar" JASDHKAJSD "Foo Bar"
# RUST_LOG=info cargo test --verbose --features=full,feat-ibc,testnet,devnet bitcoin --jobs 1 -- --ignored