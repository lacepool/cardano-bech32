# frozen_string_literal: true

RSpec.describe Cardano::Bech32::Address do
  describe ".decode" do
    [AddressFixtures::Mainnet::ADDRESSES, AddressFixtures::Testnet::ADDRESSES].each do |addresses|
      addresses.each do |name, addr|
        it "decodes CIP-19 #{addr[:network]} test vector #{name} correctly" do
          address = described_class.decode(addr[:bech])

          expect(address.network).to eq(addr[:network])
          expect(address.address_type).to eq(addr[:type])
          expect(address.payment_credential).to eq(addr[:payment])
          expect(address.stake_credential).to eq(addr[:stake])
          expect(address.payload_bytes).to eq(addr[:payload_bytes])

          # verify correct subclass
          klass = addr[:type] == :stake ? described_class::Stake : described_class::Payment
          expect(address).to be_a(klass)
        end
      end
    end

    it "raises InvalidFormat for invalid bech32 strings" do
      expect {
        described_class.decode("not-a-bech32-string")
      }.to raise_error(Cardano::Bech32::InvalidFormat, /invalid bech32 string/)
    end
  end
end
