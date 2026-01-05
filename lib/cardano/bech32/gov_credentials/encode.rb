# frozen_string_literal: true

require "bech32"
require_relative "header"
require_relative "abstract_credential"

module Cardano
  module Bech32
    # CIP-0129 Governance Credentials
    module GovCredentials
      class << self
        #
        # Encode a governance-related Bech32 object
        #
        # Supports:
        # - Governance credentials (header + hash payload)
        # - Governance actions (txid#index)
        #
        # @param payload [String, Array<Integer>] Hex string or byte array
        # @return [String] Bech32 encoded governance credential
        #
        # Raises:
        # - ArgumentError
        #
        def encode(input)
          case input
          when String
            if gov_action_ref?(input)
              GovAction.encode(input)
            else
              encode_credential(input)
            end
          when Array
            encode_credential(input)
          else
            raise ArgumentError, "invalid input type: #{input.class}"
          end
        end

        private

        def encode_credential(payload)
          bytes = bytes_from_payload(payload)
          raise ArgumentError, "empty payload" if bytes.empty?

          header_byte = bytes.first
          hrp = Header.hrp(header_byte)
          data = Cardano::Bech32.convert_bits(bytes, from_bits: 8, to_bits: 5, pad: true)

          Cardano::Bech32.encode(hrp, data)
        end

        def gov_action_ref?(value)
          value.include?("#")
        end

        def bytes_from_payload(payload)
          case payload
          when String
            if payload.match?(/\A[0-9a-fA-F]+\z/) && payload.length.even?
              [payload].pack("H*").bytes
            else
              payload.bytes
            end
          when Array
            payload
          else
            raise ArgumentError, "invalid payload type: #{payload.class}"
          end
        end
      end
    end
  end
end
