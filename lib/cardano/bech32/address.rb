# frozen_string_literal: true

require "bech32"
require_relative "address/payment"
require_relative "address/stake"

module Cardano
  module Bech32
    # Module for Cardano Bech32 addresses
    module Address
      class InvalidAddress < StandardError; end

      module Credential
        KEY    = :key
        SCRIPT = :script
      end

      module Type
        BASE       = :base
        POINTER    = :pointer
        ENTERPRISE = :enterprise
        STAKE      = :stake
      end

      ADDRESS_TYPE_BY_HEADER = {
        0b0000 => Type::BASE,
        0b0001 => Type::BASE,
        0b0010 => Type::BASE,
        0b0011 => Type::BASE,
        0b0100 => Type::POINTER,
        0b0101 => Type::POINTER,
        0b0110 => Type::ENTERPRISE,
        0b0111 => Type::ENTERPRISE,
        0b1110 => Type::STAKE,
        0b1111 => Type::STAKE
      }.freeze

      def self.address_type(header)
        high_nibble = high_nibble_from_header(header)

        ADDRESS_TYPE_BY_HEADER.fetch(high_nibble) do
          raise InvalidAddress, "Unknown header type: #{header.to_s(2)}"
        end
      end

      # Payment credential: only exists for Base, Pointer, Enterprise
      # Last bit of high nibble (0 = key, 1 = script)
      def self.payment_credential_kind(header, address_type)
        return nil if address_type == Type::STAKE

        (high_nibble_from_header(header) & 0b0001).zero? ? Credential::KEY : Credential::SCRIPT
      end

      # Stake credential: varies by address type
      def self.stake_credential_kind(header, address_type)
        case address_type
        when Type::STAKE
          # last bit of high nibble: 0 = key, 1 = script
          (high_nibble_from_header(header) & 0b0001).zero? ? Credential::KEY : Credential::SCRIPT
        when Type::BASE
          # third bit of high nibble: 1 = script, 0 = key
          (high_nibble_from_header(header) & 0b0010).zero? ? Credential::KEY : Credential::SCRIPT
        end
      end

      def self.network_symbol(header)
        header & 0x0F == 1 ? :mainnet : :testnet
      end

      def self.high_nibble_from_header(header)
        (header & 0b11110000) >> 4
      end

      def self.decode(bech32)
        hrp, data = Cardano::Bech32.decode(bech32)
        raise InvalidAddress, "Invalid Bech32 string" if hrp.nil? || data.nil?

        # Convert 5-bit array to bytes
        payload_bytes = ::Bech32.convert_bits(data, 5, 8, true)
        raise InvalidAddress, "Invalid payload length" unless payload_bytes.length.positive?

        header = payload_bytes.first
        type = address_type(header)
        klass = type == :stake ? Stake : Payment

        klass.new(
          hrp: hrp,
          network: network_symbol(header),
          payload_bytes: payload_bytes,
          header: header
        )
      end
    end
  end
end
