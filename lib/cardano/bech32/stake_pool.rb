# frozen_string_literal: true

require "bech32"

module Cardano
  module Bech32
    # Module for encoding and decoding Cardano stake pool identifiers.
    module StakePool
      HRP = "pool"
      POOL_HASH_LENGTH = 28 # bytes (blake2b-224)

      module_function

      # Encode a stake pool hash into Bech32.
      #
      # @param pool_hash [String] 56-char hex string or 28-byte binary string
      # @return [String] Bech32 stake pool id
      def encode(pool_hash)
        raise InvalidPayload, "pool_hash must be a String" unless pool_hash.is_a?(String)

        payload =
          if pool_hash.encoding == Encoding::BINARY
            pool_hash
          elsif pool_hash.match?(/\A[0-9a-fA-F]{56}\z/)
            [pool_hash].pack("H*")
          else
            raise InvalidPayload, "pool_hash must be 28 bytes or 56 hex chars"
          end

        raise InvalidPayload, "invalid pool hash length" unless payload.bytesize == POOL_HASH_LENGTH

        data = ::Bech32.convert_bits(payload.bytes, 8, 5, true)
        ::Bech32.encode(HRP, data, ::Bech32::Encoding::BECH32)
      end

      # Decode a Bech32 stake pool id.
      #
      # @param bech32 [String]
      # @return [Hash] with keys :bytes (28-byte binary string) and :hex (56-char hex string)
      def decode(bech32)
        hrp, data = Cardano::Bech32.decode(bech32)

        raise InvalidFormat, "invalid bech32 string" unless hrp && data
        raise InvalidFormat, "invalid stake pool HRP: #{hrp}" unless hrp == HRP

        bytes = ::Bech32.convert_bits(data, 5, 8, false)
        raise InvalidPayload, "invalid payload" unless bytes
        raise InvalidPayload, "invalid pool hash length" unless bytes.length == POOL_HASH_LENGTH

        {
          bytes: bytes.pack("C*"),
          hex: bytes.pack("C*").unpack1("H*")
        }
      end

      # Check whether a Bech32 string is a valid stake pool id.
      #
      # @param bech32 [String]
      # @return [Boolean]
      def valid?(bech32)
        decode(bech32)
        true
      rescue Error
        false
      end
    end
  end
end
