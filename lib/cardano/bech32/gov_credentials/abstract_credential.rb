# frozen_string_literal: true

require_relative "header"

module Cardano
  module Bech32
    module GovCredentials
      # Abstract base class for CIP-0129 governance credentials
      #
      # Header byte is authoritative and is interpreted exclusively
      # via GovCredentials::Header.
      class AbstractCredential
        attr_reader :credential,
                    :hash_bytes,
                    :header_byte,
                    :hrp,
                    :key_type,
                    :payload_bytes,
                    :payload_hex

        HASH_SIZE = 28

        def initialize(hrp:, payload_bytes:)
          @payload_bytes = payload_bytes
          @header_byte   = payload_bytes.first
          @credential    = Header.credential_type(@header_byte)
          @hash_bytes    = payload_bytes[1..]
          @hrp           = hrp
          @key_type      = Header.key_type(@header_byte)
          @payload_hex   = @payload_bytes.pack("C*").unpack1("H*").encode(Encoding::UTF_8)

          validate!
        end

        # -----------------------------
        # KeyType helpers
        # -----------------------------

        def key?    = @key_type == Header::KeyType::KEY
        def script? = @key_type == Header::KeyType::SCRIPT

        # Returns a JSON-safe hash representation
        #
        # @return [Hash]
        def to_h
          {
            credential: @credential,
            hash_bytes: @hash_bytes,
            header_byte: @header_byte,
            hrp: @hrp,
            key_type: @key_type,
            payload_bytes: @payload_bytes,
            payload_hex: @payload_hex
          }
        end

        private

        # -----------------------------
        # Validation
        # -----------------------------

        def validate!
          unless @hash_bytes.length == HASH_SIZE
            raise InvalidPayload,
                  "invalid hash length: expected #{HASH_SIZE} bytes, got #{@hash_bytes.length}"
          end

          expected_hrp = Header.hrp(@header_byte)
          unless @hrp == expected_hrp
            raise InvalidFormat,
                  "HRP mismatch: expected #{expected_hrp}, got #{@hrp}"
          end

          return if @payload_bytes.length > 1

          raise InvalidPayload,
                "payload must include header + hash, got #{@payload_bytes.length} bytes"
        end
      end
    end
  end
end
