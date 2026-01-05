# frozen_string_literal: true

RSpec.describe Cardano::Bech32::StakePool do
  let(:pool_hash)    { "6e90911fdb579e203f556f3f24aca5b8714be049ccf716008ab849fd" }
  let(:binary_hash)  { [pool_hash].pack("H*") }
  let(:pool_id)      { "pool1d6gfz87m270zq064duljft99hpc5hczfenm3vqy2hpyl67tteq9" }

  describe ".decode" do
    it "decodes a valid pool id" do
      decoded = described_class.decode(pool_id)

      expect(decoded[:hex]).to eq(pool_hash)
      expect(decoded[:bytes].length).to eq(28)
    end

    it "raises InvalidFormat for invalid stake pool HRP" do
      invalid = "addr1qx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3n0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgse35a3x"
      expect {
        described_class.decode(invalid)
      }.to raise_error(Cardano::Bech32::InvalidFormat, /invalid stake pool HRP/)
    end

    it "raises InvalidFormat for invalid bech32 input" do
      expect {
        described_class.decode("not-bech32-string")
      }.to raise_error(Cardano::Bech32::InvalidFormat, /invalid bech32 string/)
    end
  end

  describe ".valid?" do
    it "returns true for a valid pool id" do
      expect(described_class.valid?(pool_id)).to be true
    end

    it "returns false for an invalid pool id" do
      expect(described_class.valid?("pool1invalidpoolid")).to be false
    end
  end

  describe ".encode" do
    context "when pool_hash is a byte string" do
      it "encodes a 28-byte binary string" do
        bech32 = described_class.encode(binary_hash)
        expect(bech32).to eql(pool_id)
      end
    end

    it "encodes a valid pool hash" do
      bech32 = described_class.encode(pool_hash)
      expect(bech32).to eq(pool_id)
    end

    it "rejects invalid pool hash length" do
      expect {
        described_class.encode("deadbeef")
      }.to raise_error(Cardano::Bech32::InvalidPayload, /must be 28 bytes or 56 hex chars/)
    end
  end
end
