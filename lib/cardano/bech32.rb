# frozen_string_literal: true

require_relative "bech32/version"
require_relative "bech32/gov_action"
require_relative "bech32/address"
require_relative "bech32/stake_pool"

module Cardano
  # Bech32 module for encoding and decoding Cardano Bech32 identifiers.
  module Bech32
    # Maximum length for a Bech32-encoded Cardano identifier.
    # Chosen to be very high (2048) to allow all current and foreseeable
    # identifiers while protecting against excessively long/malformed input.
    MAX_BECH32_LENGTH = 2048

    # The Bech32 variant (Bech32 vs Bech32m) returned by the bech32rb decoder is not
    # reliable for Cardano identifiers. Decoding here is used for syntax and
    # checksum validation only; Cardano semantics are derived from the payload.
    # This approach is spec-correct, library-agnostic, and robust to future address formats.
    def self.decode(bech32)
      hrp, data, _spec = ::Bech32.decode(bech32, MAX_BECH32_LENGTH)
      [hrp, data]
    rescue StandardError
      raise InvalidFormat, "invalid bech32 encoding"
    end

    class Error < StandardError; end
    class InvalidFormat < Error; end
    class InvalidPayload < Error; end
  end
end
