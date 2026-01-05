# frozen_string_literal: true

require "bech32"
require_relative "cc"
require_relative "drep"
require_relative "header"
require_relative "abstract_credential"

module Cardano
  module Bech32
    # CIP-0129 Governance Credentials
    module GovCredentials
      class << self
        # Decode a governance credential
        #
        # @param bech32 [String] Bech32 encoded governance credential
        # @return [AbstractCredential, GovAction]
        #
        # Raises:
        # - Cardano::Bech32::InvalidFormat
        # - Cardano::Bech32::InvalidPayload
        #
        def decode(bech32)
          hrp, data = Cardano::Bech32.decode(bech32)
          raise InvalidFormat, "invalid bech32 string" if hrp.nil? || data.nil?

          case hrp
          when "gov_action"
            GovAction.decode_from_data(data)
          when "cc_hot", "cc_cold", "drep"
            # when Header::HRP_BY_CREDENTIAL_TYPE.values
            decode_credential(hrp, data)
          else
            raise InvalidFormat, "unknown governance HRP: #{hrp}"
          end
        end

        private

        def decode_credential(hrp, data)
          payload_bytes =
            Cardano::Bech32.convert_bits(data, from_bits: 5, to_bits: 8, pad: false)

          raise InvalidPayload, "empty payload" if payload_bytes.empty?

          header_byte = payload_bytes.first
          credential_type = Header.credential_type(header_byte)

          klass =
            case credential_type
            when Header::CredentialType::CC_HOT, Header::CredentialType::CC_COLD
              Cc
            when Header::CredentialType::DREP
              Drep
            else
              raise InvalidFormat, "unknown governance credential header: #{header_byte}"
            end

          klass.new(hrp: hrp, payload_bytes: payload_bytes)
        end
      end
    end
  end
end
