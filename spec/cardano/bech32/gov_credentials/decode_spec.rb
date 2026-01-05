# frozen_string_literal: true

RSpec.describe Cardano::Bech32::GovCredentials do
  let(:cc_cold_credential) { GovCredentialFixtures::CC_COLD_CREDENTIAL }
  let(:cc_hot_credential)  { GovCredentialFixtures::CC_HOT_CREDENTIAL }
  let(:drep_credential)    { GovCredentialFixtures::DREP_CREDENTIAL }
  let(:gov_action)         { GovCredentialFixtures::GOV_ACTION }

  describe ".decode" do
    it "decodes a CC Cold Script credential" do
      cred = described_class.decode(cc_cold_credential[:bech32])

      expect(cred).to be_a(Cardano::Bech32::GovCredentials::Cc)
      expect(cred.credential).to eq(:cc_cold)
      expect(cred.script?).to be(true)
      expect(cred.hrp).to eq("cc_cold")
      expect(cred.payload_hex).to eq(cc_cold_credential[:payload_hex])
    end

    it "decodes a CC Hot Key credential" do
      cred = described_class.decode(cc_hot_credential[:bech32])

      expect(cred).to be_a(Cardano::Bech32::GovCredentials::Cc)
      expect(cred.credential).to eq(:cc_hot)
      expect(cred.key?).to be(true)
      expect(cred.hrp).to eq("cc_hot")
      expect(cred.payload_hex).to eq(cc_hot_credential[:payload_hex])
    end

    it "decodes a DRep Key credential" do
      cred = described_class.decode(drep_credential[:bech32])

      expect(cred).to be_a(Cardano::Bech32::GovCredentials::Drep)
      expect(cred.credential).to eq(:drep)
      expect(cred.key?).to be(true)
      expect(cred.hrp).to eq("drep")
      expect(cred.payload_hex).to eq(drep_credential[:payload_hex])
    end

    it "decodes a Governance Action ID" do
      cred = described_class.decode(gov_action[:bech32])

      expect(cred).to be_a(Cardano::Bech32::GovCredentials::GovAction)
      expect(cred.tx_id).to eq(gov_action[:tx_id])
      expect(cred.index).to eq(gov_action[:index])
    end

    it "rejects invalid bech32 input" do
      expect {
        described_class.decode("not-bech32")
      }.to raise_error(Cardano::Bech32::InvalidFormat)
    end
  end
end
