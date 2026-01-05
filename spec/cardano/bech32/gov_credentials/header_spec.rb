# frozen_string_literal: true

RSpec.describe Cardano::Bech32::GovCredentials::Header do
  let(:cc_cold_header) { 0x13 } # CC Cold, Script hash
  let(:cc_hot_header)  { 0x02 } # CC Hot, Key hash
  let(:drep_key_header) { 0x22 } # DRep, Key hash

  describe ".credential_type" do
    it "detects CC Cold from header byte" do
      expect(
        described_class.credential_type(cc_cold_header)
      ).to eq(:cc_cold)
    end

    it "detects CC Hot from header byte" do
      expect(
        described_class.credential_type(cc_hot_header)
      ).to eq(:cc_hot)
    end

    it "detects DRep from header byte" do
      expect(
        described_class.credential_type(drep_key_header)
      ).to eq(:drep)
    end
  end

  describe ".key_type" do
    it "detects Key hash from header byte" do
      expect(
        described_class.key_type(cc_cold_header)
      ).to eq(:script)
    end

    it "detects" do
      expect(
        described_class.key_type(cc_hot_header)
      ).to eq(:key)

      expect(
        described_class.key_type(drep_key_header)
      ).to eq(:key)
    end
  end

  describe ".hrp" do
    it "maps CC Cold to cc_cold HRP" do
      expect(
        described_class.hrp(cc_cold_header)
      ).to eq("cc_cold")
    end

    it "maps CC Hot to cc_hot HRP" do
      expect(
        described_class.hrp(cc_hot_header)
      ).to eq("cc_hot")
    end

    it "maps DRep to drep HRP" do
      expect(
        described_class.hrp(drep_key_header)
      ).to eq("drep")
    end
  end

  describe ".build" do
    it "constructs CC Cold header byte correctly" do
      header = described_class.build(
        credential: :cc_cold,
        key_type: :script
      )

      expect(header).to eq(cc_cold_header)
    end

    it "constructs CC Hot header byte correctly" do
      header = described_class.build(
        credential: :cc_hot,
        key_type: :key
      )

      expect(header).to eq(cc_hot_header)
    end

    it "constructs DRep header byte correctly" do
      header = described_class.build(
        credential: :drep,
        key_type: :key
      )

      expect(header).to eq(drep_key_header)
    end
  end
end
