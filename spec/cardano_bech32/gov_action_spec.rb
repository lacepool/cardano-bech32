# frozen_string_literal: true

RSpec.describe CardanoBech32::GovAction do
  describe ".encode" do
    it "encodes a governance action id from txid#index (CIP-0129 example)" do
      txref = "b2a591ac219ce6dcca5847e0248015209c7cb0436aa6bd6863d0c1f152a60bc5#0"

      expect(described_class.encode(txref))
        .to eq("gov_action1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn")
    end

    it "rejects indexes outside uint8 range" do
      txref = "b2a591ac219ce6dcca5847e0248015209c7cb0436aa6bd6863d0c1f152a60bc5#256"

      expect { described_class.encode(txref) }
        .to raise_error(CardanoBech32::GovAction::InvalidPayload)
    end

    it "rejects malformed tx references" do
      expect { described_class.encode("invalid") }
        .to raise_error(CardanoBech32::GovAction::InvalidFormat)
    end
  end

  describe ".decode" do
    it "decodes a governance action id into tx_id and index" do
      bech32 =
        "gov_action1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn"

      expect(described_class.decode(bech32)).to eq(
        {
          tx_id: "b2a591ac219ce6dcca5847e0248015209c7cb0436aa6bd6863d0c1f152a60bc5",
          index: 0
        }
      )
    end

    it "rejects invalid HRP" do
      invalid =
        "addr1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn"

      expect { described_class.decode(invalid) }
        .to raise_error(CardanoBech32::GovAction::InvalidFormat)
    end

    it "rejects invalid bech32 strings" do
      invalid = "gov_action1invalid"

      expect { described_class.decode(invalid) }
        .to raise_error(CardanoBech32::GovAction::InvalidFormat)
    end
  end

  describe ".valid?" do
    it "returns true for valid governance action ids" do
      bech32 =
        "gov_action1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn"

      expect(described_class.valid?(bech32)).to be(true)
    end

    it "returns false for invalid strings" do
      expect(described_class.valid?("invalid")).to be(false)
    end
  end
end
