# Key Split (Onchain)

```
Utilize onchain data to split the key

Usage: anchor keysplit onchain [OPTIONS] --keystore-path <PATH> --password <PASSWORD> --owner <ADDRESS> --output-path <OUTPUT PATH> --operators <IDS> --rpc <ENDPOINT>

Options:
  -d, --data-dir <DIR>             Used to specify a custom root data directory for the Anchor key and database.
                                   Defaults to $HOME/.anchor/{network} where network is the value of the `network` flag
                                   Note: Users should specify separate custom datadirs for different networks.
      --keystore-path <PATH>       Path to the validator keystore file
      --network <NETWORK>          Name of the chain Anchor will validate. Mainnet is not supported. [default: hoodi]
                                   [possible values: holesky, hoodi]
  -t, --testnet-dir <DIR>          Path to directory containing eth2_testnet specs.
      --password <PASSWORD>        Password for the validator keystore
      --owner <ADDRESS>            EOA address that owns the validator
      --debug-level <DEBUG_LEVEL>  Specifies the verbosity level used when emitting logs to the terminal [default:
                                   INFO]
      --output-path <OUTPUT PATH>  Path for output
      --operators <IDS>            Operators to split key among
      --rpc <ENDPOINT>             RPC endpoint to access L1 data
  -h, --help                       Print help
```

<style> .content main {max-width:88%;} </style>
