# frozen_string_literal: true

require_relative "abstract_credential"

module Cardano
  module Bech32
    module GovCredentials
      # Class for DRep credentials
      class Drep < AbstractCredential; end
    end
  end
end
