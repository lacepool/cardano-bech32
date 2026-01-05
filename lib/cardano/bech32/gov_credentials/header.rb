# frozen_string_literal: true

module Cardano
  module Bech32
    module GovCredentials
      # Header byte utilities for Governance credentials
      module Header
        #
        # CIP-0129 Header byte layout:
        #
        #   7 6 5 4 | 3 2 1 0
        #   --------+--------
        #   credential type | key type
        #
        # High nibble (credential type):
        #   0000 = CC Hot
        #   0001 = CC Cold
        #   0010 = DRep
        #
        # Lower nibble (key type):
        #   0010 = Key hash
        #   0011 = Script hash
        #

        # -----------------------------
        # Key Types (upper nibble)
        # -----------------------------

        module CredentialType
          CC_HOT  = :cc_hot
          CC_COLD = :cc_cold
          DREP    = :drep
        end

        CREDENTIAL_TYPE_BY_NIBBLE = {
          0b0000 => CredentialType::CC_HOT,
          0b0001 => CredentialType::CC_COLD,
          0b0010 => CredentialType::DREP
        }.freeze

        NIBBLE_BY_CREDENTIAL_TYPE = CREDENTIAL_TYPE_BY_NIBBLE.invert.freeze

        # -----------------------------
        # Key Types (lower nibble)
        # -----------------------------

        module KeyType
          KEY    = :key
          SCRIPT = :script
        end

        KEY_TYPE_BY_NIBBLE = {
          0b0010 => KeyType::KEY,
          0b0011 => KeyType::SCRIPT
        }.freeze

        NIBBLE_BY_KEY_TYPE = KEY_TYPE_BY_NIBBLE.invert.freeze

        # -----------------------------
        # HRP Mapping (by key type)
        # -----------------------------

        HRP_BY_CREDENTIAL_TYPE = {
          CredentialType::CC_HOT => "cc_hot",
          CredentialType::CC_COLD => "cc_cold",
          CredentialType::DREP => "drep"
        }.freeze

        # -----------------------------
        # Public API
        # -----------------------------

        def self.credential_type(header)
          nibble = high_nibble(header)

          CREDENTIAL_TYPE_BY_NIBBLE.fetch(nibble) do
            raise InvalidFormat, "Unknown governance credential type: #{nibble.to_s(2)}"
          end
        end

        def self.key_type(header)
          nibble = low_nibble(header)

          KEY_TYPE_BY_NIBBLE.fetch(nibble) do
            raise InvalidFormat, "Unknown governance key type: #{nibble.to_s(2)}"
          end
        end

        def self.hrp(header)
          HRP_BY_CREDENTIAL_TYPE.fetch(credential_type(header))
        end

        # -----------------------------
        # Header Construction
        # -----------------------------

        def self.build(key_type:, credential:)
          cred_nibble = NIBBLE_BY_CREDENTIAL_TYPE.fetch(credential) do
            raise ArgumentError, "Invalid credential type: #{credential}"
          end

          key_nibble = NIBBLE_BY_KEY_TYPE.fetch(key_type) do
            raise ArgumentError, "Invalid key type: #{key_type}"
          end

          ((cred_nibble << 4) | key_nibble) & 0xFF
        end

        # -----------------------------
        # Bit Helpers
        # -----------------------------

        def self.high_nibble(header)
          (header & 0b1111_0000) >> 4
        end

        def self.low_nibble(header)
          header & 0b0000_1111
        end
      end
    end
  end
end
