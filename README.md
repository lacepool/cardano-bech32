# cardano-bech32

A small, focused Ruby library for encoding and decoding Cardano Bech32 identifiers.
This gem deliberately avoids higher-level ledger concerns and focuses solely on **specification-compliant Bech32 handling**.

## Supported Identifiers

- [x] Governance [CIP-0129](https://cips.cardano.org/cip/CIP-0129)
  - [x] GovAction IDs
  - [x] DRep IDs
  - [x] CC hot/cold
- [x] Addresses
  - [x] Base Address
  - [x] Enterprise Address
  - [x] Pointer Address
  - [x] Stake Address
- [x] Stake Pool IDs

The API is designed to grow conservatively as additional Cardano Improvement Proposals (CIPs) are implemented.

## Installation

Add to your Gemfile:

```ruby
gem "cardano-bech32"
```

And then execute:

```sh
bundle install
```

Or install directly:

```sh
gem install cardano-bech32
```

## Usage

### Governance Credentials (CIP-0129)

Cardano governance identifiers defined in CIP-0129 are Bech32-encoded binary payloads used throughout on-chain governance.

This library supports all CIP-0129 governance identifiers, including:

* Constitutional Committee credentials (hot & cold)
* DRep credentials
* Governance Action IDs

#### Constitutional Committee & DRep Credentials

Governance credentials consist of:

```
header (1 byte) || credential hash (N bytes)
```

The header byte is authoritative and encodes:
* Credential type (CC Hot, CC Cold, DRep)
* Key type (key hash or script hash)

The HRP is derived from the header and validated during decoding.

Decode a governance credential

```
require "cardano/bech32"

cred = Cardano::Bech32::GovCredentials.decode(
  "cc_cold1zvqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6kflvs"
)

cred.credential      # => :cc_cold
cred.hash_bytes      # => [0, 0, 0, ...]
cred.header_byte     # => 19
cred.hrp             # => "cc_cold"
cred.key_type        # => :script
cred.payload_bytes   # => [19, 0, 0, ...]
cred.payload_hex     # => "1300000000..."
```

The returned object is one of:
* `Cardano::Bech32::GovCredentials::Cc`
* `Cardano::Bech32::GovCredentials::Drep`

Both inherit from `AbstractCredential` and expose a uniform interface.

Encode a governance credential

```
payload_hex = "130000000000000000000000000000000000000000000000000000000000"

bech32 = Cardano::Bech32::GovCredentials.encode(payload_hex)
# => "cc_cold1zvqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6kflvs"
```

The encoder:
* Accepts raw bytes or hex
* Infers HRP from the header byte


#### Governance Action IDs

Governance Action IDs identify a governance action on-chain and consist of:


```
tx_id (32 bytes) || index (1 byte)
```

They are encoded as Bech32 using HRP `gov_action`.

```ruby
require "cardano/bech32"

txref = "b2a591ac219ce6dcca5847e0248015209c7cb0436aa6bd6863d0c1f152a60bc5#0"
bech32 = Cardano::Bech32::GovAction.encode(txref)
# => "gov_action1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn"

gov_action = Cardano::Bech32::GovAction.decode(bech32)
gov_action.tx_id          # => "b2a591ac219ce6dcca5847e0248015209c7cb0436aa6bd6863d0c1f152a60bc5"
gov_action.index          # => 0
gov_action.payload_bytes  # => [178, 165, 145, 172, ...]
gov_action.hrp            # => "gov_action"

Cardano::Bech32::GovAction.valid?(bech32)
# => true
```

All decoding/validation failures for `GovAction` raise explicit, typed errors:

* `Cardano::Bech32::GovAction::InvalidFormat` — malformed input, wrong HRP, invalid Bech32
* `Cardano::Bech32::GovAction::InvalidPayload` — incorrect payload length, invalid index

```ruby
begin
  Cardano::Bech32::GovAction.decode("invalid")
rescue Cardano::Bech32::GovAction::InvalidFormat,
       Cardano::Bech32::GovAction::InvalidPayload => e
  puts e.message
end
```



### Stake Pool IDs

Stake Pool IDs are Bech32-encoded 28-byte hashes identifying a registered stake pool.

```ruby
pool_hash = "6e90911fdb579e203f556f3f24aca5b8714be049ccf716008ab849fd"
Cardano::Bech32::StakePool.encode(pool_hash)
# => pool1d6gfz87m270zq064duljft99hpc5hczfenm3vqy2hpyl67tteq9

pool_id = "pool1d6gfz87m270zq064duljft99hpc5hczfenm3vqy2hpyl67tteq9"
Cardano::Bech32::StakePool.decode(pool_id)
# => { bytes: "\x8C\xB8\...", hex: "6e90911..." }

Cardano::Bech32::StakePool.valid?(pool_id)
# => true
```

### Addresses

```ruby
# Decode a Cardano Address
addr_bech32 = "addr1qx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3n0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgse35a3x"
address = CardanoBech32::Address.decode(addr_bech32)

address.address_type         # => :base, :stake, :pointer, or :enterprise
address.payment_credential   # => :key or :script (nil for stake/pointer-only addresses)
address.stake_credential     # => :key or :script (nil if not applicable)
address.network              # => network string derived from HRP
```

#### Bech32 and Cardano Addresses

Some Bech32 libraries may report the variant incorrectly (Bech32 / Bech32m), but for Cardano this does **not affect validity**.

This library validates addresses based on:

* The HRP (`addr`, `addr_test`, `stake`, etc.)
* The header byte
* The network id encoded in the payload

Checksum and payload parsing are fully specification-compliant.

## Development

After checking out the repo:

```
bin/setup       # install dependencies
rake spec       # run tests
bin/console     # interactive console
```

To install locally:

```
bundle exec rake install
```

To release a new version:

```
# update version.rb
bundle exec rake release
```

This creates a git tag, pushes commits, and uploads the gem to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lacepool/cardano-bech32.
Please follow the [code of conduct](https://github.com/lacepool/cardano-bech32/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
