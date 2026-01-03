# frozen_string_literal: true

module Cardano
  # Bech32 module for encoding and decoding Cardano Bech32 identifiers.
  module Bech32
    # Maximum length for a Bech32-encoded Cardano identifier.
    # Chosen to be very high (2048) to allow all current and foreseeable
    # identifiers while protecting against excessively long/malformed input.
    MAX_BECH32_LENGTH = 2048

    # Wrapper around bech32rb encode function.
    # @param hrp [String] human-readable part
    # @param data [Array<Integer>] data as array of integers
    # @return [String] Bech32-encoded string
    def self.encode(hrp, data)
      ::Bech32.encode(hrp, data, ::Bech32::Encoding::BECH32)
    end

    # Wrapper around bech32rb decode function.
    # @param bech32 [String]
    # @return [Array(String, Array<Integer>), nil] human-readable part and data
    def self.decode(bech32)
      hrp, data, _spec = ::Bech32.decode(bech32, MAX_BECH32_LENGTH)
      [hrp, data]
    rescue StandardError
      raise InvalidFormat, "invalid bech32 string"
    end

    # Convert bits between different bases.
    # @param data [Array<Integer>] input data as array of integers
    # @param from_bits [Integer] number of bits per input value
    # @param to_bits [Integer] number of bits per output value
    # @param pad [Boolean] whether to pad the output
    # @return [Array<Integer>, nil] converted data as array of integers, or nil on failure
    def self.convert_bits(data, from_bits: 5, to_bits: 8, pad: true)
      ::Bech32.convert_bits(data, from_bits, to_bits, pad)
    rescue StandardError
      nil
    end

    class Error < StandardError; end
    class InvalidFormat < Error; end
    class InvalidPayload < Error; end
  end
end

require_relative "bech32/version"
require_relative "bech32/gov_action"
require_relative "bech32/address"
require_relative "bech32/stake_pool"
