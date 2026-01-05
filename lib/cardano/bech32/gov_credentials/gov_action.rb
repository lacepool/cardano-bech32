# frozen_string_literal: true

require "bech32"

module Cardano
  module Bech32
    module GovCredentials
      # Bech32 encoding for governance action references.
      # A governance action reference is of the form "txid#index"
      # where txid is a 32-byte hex string and index is a 0..255 integer
      # The Bech32 encoding has HRP "gov_action" and a payload of 33 bytes:
      # - 32 bytes: txid (binary)
      # - 1 byte: index (binary)
      #
      class GovAction
        HRP = "gov_action"
        TX_ID_BYTES = 32
        INDEX_BYTES = 1
        TOTAL_BYTES = TX_ID_BYTES + INDEX_BYTES

        attr_reader :tx_id, :index, :payload_bytes, :hrp

        def initialize(hrp:, payload_bytes:)
          @payload_bytes = payload_bytes
          @index         = payload_bytes.last
          @tx_id         = payload_bytes[0, TX_ID_BYTES].pack("C*").unpack1("H*").encode(Encoding::UTF_8)
          @hrp           = hrp

          validate!
        end

        def self.encode(tx_ref)
          txid_hex, index_str = tx_ref.split("#", 2)
          index = index_str.to_i if index_str

          raise InvalidFormat, "expected txid#index" unless txid_hex && index
          raise InvalidFormat, "invalid hex" unless txid_hex.match?(/\A[0-9a-fA-F]{64}\z/)

          payload_bytes = [txid_hex].pack("H*").bytes + [index]

          raise InvalidPayload, "invalid payload length" unless payload_bytes.length == TOTAL_BYTES
          raise InvalidPayload, "index must be 0..255" unless index.between?(0, 255)

          data = Cardano::Bech32.convert_bits(payload_bytes, from_bits: 8, to_bits: 5, pad: true)

          Cardano::Bech32.encode(HRP, data)
        end

        def self.decode(bech32)
          hrp, data = Cardano::Bech32.decode(bech32)
          raise InvalidFormat, "invalid HRP" unless hrp == HRP

          decode_from_data(data)
        end

        def self.decode_from_data(data)
          bytes = Cardano::Bech32.convert_bits(data, from_bits: 5, to_bits: 8, pad: false)
          raise InvalidPayload, "invalid payload length" unless bytes.length == TOTAL_BYTES

          new(hrp: HRP, payload_bytes: bytes)
        rescue ArgumentError
          raise InvalidFormat, "invalid bech32 encoding"
        end

        def self.valid?(bech32)
          decode(bech32)
          true
        rescue Error
          false
        end

        def validate!
          return if @payload_bytes.length == TOTAL_BYTES

          raise InvalidPayload,
                "invalid payload length: expected #{TOTAL_BYTES} bytes, got #{@payload_bytes.length}"
        end
      end
    end
  end
end
