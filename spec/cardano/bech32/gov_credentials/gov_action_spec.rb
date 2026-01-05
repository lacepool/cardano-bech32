# frozen_string_literal: true

RSpec.describe Cardano::Bech32::GovCredentials::GovAction do
  describe ".encode" do
    it "encodes a governance action id from txid#index (CIP-0129 example)" do
      txref = GovCredentialFixtures::GOV_ACTION[:txref]

      expect(described_class.encode(txref))
        .to eq(GovCredentialFixtures::GOV_ACTION[:bech32])
    end

    it "rejects indexes outside uint8 range" do
      txref = "#{GovCredentialFixtures::GOV_ACTION[:tx_id]}#256"

      expect { described_class.encode(txref) }
        .to raise_error(Cardano::Bech32::InvalidPayload)
    end

    it "rejects malformed tx references" do
      txref = "invalid-txref-format"

      expect { described_class.encode(txref) }
        .to raise_error(Cardano::Bech32::InvalidFormat)
    end
  end

  describe ".decode" do
    it "decodes a governance action id into tx_id and index" do
      result = described_class.decode(GovCredentialFixtures::GOV_ACTION[:bech32])

      expect(result.tx_id).to eq(GovCredentialFixtures::GOV_ACTION[:tx_id])
      expect(result.index).to eq(GovCredentialFixtures::GOV_ACTION[:index])
    end

    it "rejects invalid HRP" do
      invalid =
        "addr1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn"

      expect { described_class.decode(invalid) }
        .to raise_error(Cardano::Bech32::InvalidFormat)
    end

    it "rejects invalid bech32 strings" do
      invalid = "gov_action1invalid"

      expect { described_class.decode(invalid) }
        .to raise_error(Cardano::Bech32::InvalidFormat)
    end
  end

  describe ".valid?" do
    it "returns true for valid governance action ids" do
      bech32 =
        GovCredentialFixtures::GOV_ACTION[:bech32]

      expect(described_class.valid?(bech32)).to be(true)
    end

    it "returns false for invalid strings" do
      expect(described_class.valid?("invalid")).to be(false)
    end
  end
end
