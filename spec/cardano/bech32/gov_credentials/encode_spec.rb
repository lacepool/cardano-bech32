# frozen_string_literal: true

RSpec.describe Cardano::Bech32::GovCredentials do
  let(:cc_cold_credential) { GovCredentialFixtures::CC_COLD_CREDENTIAL }
  let(:cc_hot_credential)  { GovCredentialFixtures::CC_HOT_CREDENTIAL }
  let(:drep_credential)    { GovCredentialFixtures::DREP_CREDENTIAL }
  let(:gov_action)         { GovCredentialFixtures::GOV_ACTION }

  describe ".encode" do
    context "from hex" do
      it "encodes CC Cold Script to Bech32" do
        bech32 = described_class.encode(cc_cold_credential[:payload_hex])
        expect(bech32).to eq(cc_cold_credential[:bech32])
      end

      it "encodes CC Hot Key to Bech32" do
        bech32 = described_class.encode(cc_hot_credential[:payload_hex])
        expect(bech32).to eq(cc_hot_credential[:bech32])
      end

      it "encodes DRep Key to Bech32" do
        bech32 = described_class.encode(drep_credential[:payload_hex])
        expect(bech32).to eq(drep_credential[:bech32])
      end

      it "encodes Gov Action ID to Bech32" do
        bech32 = described_class.encode(gov_action[:txref])
        expect(bech32).to eq(gov_action[:bech32])
      end
    end

    context "from bytes" do
      it "encodes CC Cold Script to Bech32" do
        bech32 = described_class.encode(cc_cold_credential[:payload_bytes])
        expect(bech32).to eq(cc_cold_credential[:bech32])
      end

      it "encodes CC Hot Key to Bech32" do
        bech32 = described_class.encode(cc_hot_credential[:payload_bytes])
        expect(bech32).to eq(cc_hot_credential[:bech32])
      end

      it "encodes DRep Key to Bech32" do
        bech32 = described_class.encode(drep_credential[:payload_bytes])
        expect(bech32).to eq(drep_credential[:bech32])
      end
    end

    context "from byte string" do
      it "encodes CC Cold Script to Bech32" do
        byte_string = cc_cold_credential[:payload_bytes].pack("C*")
        bech32 = described_class.encode(byte_string)
        expect(bech32).to eq(cc_cold_credential[:bech32])
      end

      it "encodes CC Hot Key to Bech32" do
        byte_string = cc_hot_credential[:payload_bytes].pack("C*")
        bech32 = described_class.encode(byte_string)
        expect(bech32).to eq(cc_hot_credential[:bech32])
      end

      it "encodes DRep Key to Bech32" do
        byte_string = drep_credential[:payload_bytes].pack("C*")
        bech32 = described_class.encode(byte_string)
        expect(bech32).to eq(drep_credential[:bech32])
      end
    end

    it "round-trips encode → decode" do
      bech32 = described_class.encode(cc_cold_credential[:payload_hex])
      cred = described_class.decode(bech32)

      expect(cred.payload_hex).to eq(cc_cold_credential[:payload_hex])
      expect(cred.script?).to be(true)
    end

    it "raises when payload is missing" do
      expect {
        described_class.encode(nil)
      }.to raise_error(ArgumentError)
    end
  end
end
