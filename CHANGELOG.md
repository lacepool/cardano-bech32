## [Unreleased]

## [1.1.0] - 2026-01-05

### Fixed
- Decoding of Addresses: Byte length too long due to padding

## [1.0.0] - 2026-01-05

### Added
- Encoding of DRep IDs `drep` as defined in CIP-0129
- Decoding of `drep` Bech32 identifiers into hex and byte data
- Encoding of CC (cold / hot) IDs `cc_cold` `cc_hot` as defined in CIP-0129
- Decoding of `cc_cold` `cc_hot` into hex and byte data
- Encoding of Stake Pool identifier `pool`
- Decoding of Stake Pool identifiers into hex and byte data
- Decoding of Addresses such as Base, Stake, Pointer, Enterprise into network info, byte data

## [0.1.0] - 2025-12-29

### Added
- Initial release of `cardano-bech32`
- Encoding of Cardano Governance Action IDs (`gov_action`) as defined in CIP-0129
- Decoding of `gov_action` Bech32 identifiers into transaction ID and index
- Validation helpers for governance action identifiers
- RSpec test suite with normative CIP-0129 test vectors
