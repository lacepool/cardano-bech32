# frozen_string_literal: true

require "bech32"

module Cardano
  module Bech32
    # Bech32 encoding for governance action references.
    # A governance action reference is of the form "txid#index"
    # where txid is a 32-byte hex string and index is a 0..255 integer
    # The Bech32 encoding has HRP "gov_action" and a payload of 33 bytes:
    # - 32 bytes: txid (binary)
    # - 1 byte: index (binary)
    #
    module GovAction
      HRP = "gov_action"
      TX_ID_BYTES = 32
      INDEX_BYTES = 1
      TOTAL_BYTES = TX_ID_BYTES + INDEX_BYTES

      def self.encode(tx_ref)
        txid_hex, index_str = tx_ref.split("#", 2)
        raise InvalidFormat, "expected txid#index" unless txid_hex && index_str

        txid_bytes = hex_to_bytes(txid_hex)
        index = Integer(index_str)

        raise InvalidPayload, "txid must be 32 bytes" unless txid_bytes.bytesize == TX_ID_BYTES
        raise InvalidPayload, "index must be 0..255" unless index.between?(0, 255)

        payload = txid_bytes + [index].pack("C")
        data_5bit = ::Bech32.convert_bits(payload.bytes, 8, 5, true)

        ::Bech32.encode(HRP, data_5bit, ::Bech32::Encoding::BECH32)
      end

      def self.decode(bech32)
        hrp, data = Cardano::Bech32.decode(bech32)
        raise InvalidFormat, "invalid HRP" unless hrp == HRP

        bytes = ::Bech32.convert_bits(data, 5, 8, false)
        raise InvalidPayload, "invalid payload length" unless bytes.length == TOTAL_BYTES

        {
          tx_id: bytes_to_hex(bytes[0, TX_ID_BYTES]),
          index: bytes.last
        }
      rescue ArgumentError
        raise InvalidFormat, "invalid bech32 encoding"
      end

      def self.valid?(bech32)
        decode(bech32)
        true
      rescue Error
        false
      end

      def self.hex_to_bytes(hex)
        raise InvalidFormat, "invalid hex" unless hex.match?(/\A[0-9a-fA-F]{64}\z/)

        [hex].pack("H*")
      end

      def self.bytes_to_hex(bytes)
        bytes.pack("C*").unpack1("H*")
      end
    end
  end
end
