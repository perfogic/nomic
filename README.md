<h1 align="center">
<img src="./logo.svg" width="40%">
</h1>

Nomic Bitcoin Bridge

## Bitcoin Bridge Testnet Release

This release of the Nomic testnet activates the Bitcoin bridge. Users can now deposit testnet Bitcoin to receive NBTC tokens, transfer them, and withdraw them back to the Bitcoin testnet blockchain.

If the testing of this phase goes smoothly, we will deploy the Bitcoin bridge with mainnet BTC on the Nomic Stakenet soon after. Expect rapid improvements to the bridge in the coming months, including the activation of IBC and transfers of the NOM token.

## Upgrading existing nodes

If you're upgrading your existing testnet node:

1. Rebuild from this branch with:

```
git pull

cargo install --locked --path .
```

2. Shut down your running node.

3. Restart your node with `nomic start`.

Your node will automatically perform the upgrade on Friday, June 24th at 17:00 UTC.

## Node setup guide

This guide will walk you through setting up a node for the Nomic testnet.

If you need any help getting your node running, join the [Discord](https://discord.gg/jH7U2NRJKn) and ask for the Validator role.

### Requirements

- &gt;= 4GB RAM
- &gt;= 100GB of storage
- Linux or macOS _(Windows support coming soon)_

### 1. Build Nomic

Start by building Nomic - for now this requires Rust nightly.

```bash
# install rustup if you haven't already
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install required dependencies (ubuntu)
sudo apt install build-essential libssl-dev pkg-config clang
# or for systems running fedora
sudo dnf install clang openssl-devel && sudo dnf group install "C Development Tools and Libraries"

# clone
git clone https://github.com/nomic-io/nomic.git nomic && cd nomic

# change to testnet branch
git checkout testnet

# build and install, adding a `nomic` command to your PATH
cargo install --locked --path .
```

### 2. Run your node

```bash
nomic start
```

This will run the Nomic state machine and a Tendermint process.

### 3. Acquiring coins and staking for voting power

First, find your address by running `nomic balance` (for now this must be run on
the same machine as your active full node).

Ask the Nomic team for some coins in the Discord and include your address.

Once you have received coins, you can declare your node as a validator and
delegate to yourself with:

```
nomic declare \
  <validator_consensus_key> \
  <amount> \
  <commission_rate> \
  <max_commission_rate> \
  <max_commission_rate_change_per_day> \
  <min_self_delegation> \
  <moniker> \
  <website> \
  <identity> \
  <details>
```

**IMPORTANT NOTE:** Carefully double-check all the fields since you will not be
able to modify the `commission_max` or `commission_max_change` after declaring. If you make a mistake, you will have to
declare a new validator instead.

- The `validator_consensus_key` field is the base64 pubkey `value` field found
  under `"validator_info"` in the output of http://localhost:26657/status.
- The `identity` field is the 64-bit hex key suffix found on your Keybase
  profile, used to get your profile picture in wallets and block explorers.

For example:

```
nomic declare \
  ohFOw5u9LGq1ZRMTYZD1Y/WrFtg7xfyBaEB4lSgfeC8= \
  100000 \
  0.042 \
  0.1 \
  0.01 \
  100000 \
  "Foo's Validator" \
  "https://foovalidator.com" \
  37AA68F6AA20B7A8 \
  "Please delegate to me!"
```

### 4. Run your Bitcoin signer

The funds in the Bitcoin bridge are held in a large multisig controlled by the Nomic validators. If you are in the top 30 validator slots by voting power, you are part of this multisig and must run a signer.

You can run the signer with:
```bash
nomic signer
```

This will automatically generate a Bitcoin extended private key and store it at `~/.nomic-testnet-4/signer/xpriv`. It will also prompt you to submit your public key to the network so you can be added to the multisig.

Leave this process running, it will automatically sign Bitcoin transactions that the network wants to create.

In the future, we hope for the community to come up with alternative types of signers which provide for extra security, by e.g. airgapping keys or using HSMs.

### 5. (Optional) Run a relayer

Relayer nodes carry data between the Bitcoin blockchain and the Nomic blockchain. You can help support the health of the network by running a Bitcoin node alongside your Nomic node and running the relayer process.

#### i. Sync a Bitcoin testnet node

Download Bitcoin Core: https://bitcoin.org/en/download

Run it with:
```bash
bitcoind -testnet -server -rpcuser=satoshi -rpcpassword=nakamoto
```
(The RPC server only listens on localhost, so the user and password are not critically important.)

**NOTE:** To save on disk space, you may want to configure your Bitcoin node to prune block storage. For instance, add `-prune=2000` to only keep a maximum of 2000 MB of blocks. You may also want to use the `-daemon` option to keep the node running in the background.

#### ii. Run the relayer process

```bash
nomic relayer --rpc-port=18332 --rpc-user=satoshi --rpc-pass=nakamoto
```

Leave this running - the relayer will constantly scan the Bitcoin testnet and Nomic testnet chains and broadcast relevant data.

The relayer will also create a server which listens on port 9000 for clients to announce their deposit addresses. To help make the network more reliable, if you run a relayer please open this port and let us know your node's address in Discord or a Github issue so we can have clients make use of your node.

---

Thanks for participating in the Nomic testnet! We'll be updating the network
often so stay tuned in [Discord](https://discord.gg/jH7U2NRJKn) for updates.
