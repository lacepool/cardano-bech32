# frozen_string_literal: true

module Cardano
  module Bech32
    module Address
      # Abstract class for different types of Cardano Bech32 addresses
      class AbstractAddress
        attr_reader :hrp, :network, :payload_bytes, :header, :address_type, :payment_credential, :stake_credential

        def initialize(hrp:, network:, payload_bytes:, header:)
          @hrp           = hrp
          @network       = network
          @payload_bytes = payload_bytes
          @header        = header

          @address_type = Address.address_type(header)

          @payment_credential = Address.payment_credential_kind(@header, @address_type)
          @stake_credential   = Address.stake_credential_kind(@header, @address_type)
        end

        def base? = @address_type == :base
        def pointer? = @address_type == :pointer
        def enterprise? = @address_type == :enterprise
        def stake? = @address_type == :stake

        def script_payment? = @payment_credential == Address::Credential::SCRIPT
        def script_stake? = @stake_credential == Address::Credential::SCRIPT
      end
    end
  end
end
