# frozen_string_literal: true

require_relative "abstract_credential"

module Cardano
  module Bech32
    module GovCredentials
      # Class for Cold and Hot CC credentials
      class Cc < AbstractCredential
        def hot?  = @key_type == Header::KeyType::CC_HOT
        def cold? = @key_type == Header::KeyType::CC_COLD
      end
    end
  end
end
