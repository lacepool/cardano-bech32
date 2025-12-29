# CardanoBech32

A small, focused Ruby library for encoding and decoding Cardano Bech32 identifiers.
This gem deliberately avoids higher-level ledger concerns and focuses solely on correct, specification-compliant Bech32 handling.

Currently supported

- [x] Governance Action IDs (gov_action) — [CIP-0129](https://cips.cardano.org/cip/CIP-0129)
- [ ] Addresses
- [ ] Stake pool IDs
- [ ] DRep IDs

The API is designed to grow conservatively as additional Cardano Improvement Proposals (CIPs) are implemented.

## Installation

Add this line to your application’s Gemfile:

```sh
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

### Governance Action IDs (CIP-0129)

A Governance Action ID is derived as:
tx_id (32 bytes) || index (1 byte)
→ Bech32 encode with HRP "gov_action"

#### Encoding

```ruby
require "cardano_bech32"

txref = "b2a591ac219ce6dcca5847e0248015209c7cb0436aa6bd6863d0c1f152a60bc5#0"

CardanoBech32::GovAction.encode(txref)
# => "gov_action1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn"
```

#### Decoding

```ruby
CardanoBech32::GovAction.decode(
  "gov_action1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn"
)
# => {
  tx_id: "b2a591ac219ce6dcca5847e0248015209c7cb0436aa6bd6863d0c1f152a60bc5",
  index: 0
}
```

#### Validation

Validation checks:
* Bech32 checksum
* Correct HRP (gov_action)
* Correct payload length (33 bytes)

```ruby
CardanoBech32::GovAction.valid?("gov_action1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn")
# => true
```

### Error Handling

The library normalizes all Bech32 decoding and validation failures into
explicit, typed errors:

* InvalidFormat — malformed input, wrong HRP, invalid Bech32
* InvalidPayload — incorrect byte length, invalid index

```ruby
# Example
begin
  CardanoBech32::GovAction.encode("invalid")
rescue CardanoBech32::GovAction::Error => e
  puts e.message
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cardano_bech32. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/cardano_bech32/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CardanoBech32 project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cardano_bech32/blob/main/CODE_OF_CONDUCT.md).
