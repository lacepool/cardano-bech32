# frozen_string_literal: true

RSpec.describe Cardano::Bech32::GovCredentials::AbstractCredential do
  let(:hrp) { GovCredentialFixtures::CC_COLD_CREDENTIAL[:hrp] }
  let(:hash_bytes) { GovCredentialFixtures::CC_COLD_CREDENTIAL[:hash_bytes] }
  let(:payload_hex) { GovCredentialFixtures::CC_COLD_CREDENTIAL[:payload_hex] }
  let(:payload_bytes) { GovCredentialFixtures::CC_COLD_CREDENTIAL[:payload_bytes] }

  subject do
    described_class.new(
      hrp: hrp,
      payload_bytes: payload_bytes
    )
  end

  it "exposes credential type" do
    expect(subject.credential).to eq(:cc_cold)
  end

  it "exposes key type" do
    expect(subject.script?).to be(true)
    expect(subject.key?).to be(false)
  end

  it "exposes correct hash bytes" do
    expect(subject.hash_bytes.length).to eq(hash_bytes.length)
    expect(subject.hash_bytes).to eq(hash_bytes)
  end

  it "exposes correct payload bytes" do
    expect(subject.payload_bytes.length).to eq(payload_bytes.length)
    expect(subject.payload_bytes).to eq(payload_bytes)
  end

  it "exposes payload bytes as hex" do
    expect(subject.payload_hex).to eq(payload_hex)
  end

  it "exposes HRP" do
    expect(subject.hrp).to eq(hrp)
  end

  it "validates HRP" do
    expect {
      described_class.new(
        hrp: "foo",
        payload_bytes: payload_bytes
      )
    }.to raise_error(Cardano::Bech32::InvalidFormat)
  end

  it "is JSON-safe" do
    hash = subject.to_h

    expect(hash[:credential]).to be_a(Symbol)
    expect(hash[:hash_bytes]).to be_a(Array)
    expect(hash[:header_byte]).to be_a(Integer)
    expect(hash[:hrp]).to be_a(String)
    expect(hash[:key_type]).to be_a(Symbol)
    expect(hash[:payload_bytes]).to be_a(Array)
    expect(hash[:payload_hex]).to be_a(String)
  end
end
