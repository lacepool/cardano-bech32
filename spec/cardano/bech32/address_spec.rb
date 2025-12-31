# frozen_string_literal: true

RSpec.describe Cardano::Bech32::Address do
  describe ".decode" do
    # CIP-19 test vectors
    # https://cips.cardano.org/cip/CIP-19#test-vectors

    cip19_mainnet_addresses = {
      type_00: { bech: "addr1qx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3n0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgse35a3x",
                 network: :mainnet, type: :base, payment: :key, stake: :key },
      type_01: { bech: "addr1z8phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gten0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgs9yc0hh",
                 network: :mainnet, type: :base, payment: :script, stake: :key },
      type_02: { bech: "addr1yx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzerkr0vd4msrxnuwnccdxlhdjar77j6lg0wypcc9uar5d2shs2z78ve",
                 network: :mainnet, type: :base, payment: :key, stake: :script },
      type_03: { bech: "addr1x8phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gt7r0vd4msrxnuwnccdxlhdjar77j6lg0wypcc9uar5d2shskhj42g",
                 network: :mainnet, type: :base, payment: :script, stake: :script },
      type_04: { bech: "addr1gx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer5pnz75xxcrzqf96k",
                 network: :mainnet, type: :pointer, payment: :key, stake: nil },
      type_05: { bech: "addr128phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtupnz75xxcrtw79hu",
                 network: :mainnet, type: :pointer, payment: :script, stake: nil },
      type_06: { bech: "addr1vx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzers66hrl8",
                 network: :mainnet, type: :enterprise, payment: :key, stake: nil },
      type_07: { bech: "addr1w8phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtcyjy7wx",
                 network: :mainnet, type: :enterprise, payment: :script, stake: nil },
      type_14: { bech: "stake1uyehkck0lajq8gr28t9uxnuvgcqrc6070x3k9r8048z8y5gh6ffgw",
                 network: :mainnet, type: :stake, payment: nil, stake: :key },
      type_15: { bech: "stake178phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtcccycj5",
                 network: :mainnet, type: :stake, payment: nil, stake: :script }
    }.freeze

    cip19_testnet_addresses = {
      type_00: { bech: "addr_test1qz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3n0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgs68faae",
                 network: :testnet, type: :base, payment: :key, stake: :key },
      type_01: { bech: "addr_test1zrphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gten0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgsxj90mg",
                 network: :testnet, type: :base, payment: :script, stake: :key },
      type_02: { bech: "addr_test1yz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzerkr0vd4msrxnuwnccdxlhdjar77j6lg0wypcc9uar5d2shsf5r8qx",
                 network: :testnet, type: :base, payment: :key, stake: :script },
      type_03: { bech: "addr_test1xrphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gt7r0vd4msrxnuwnccdxlhdjar77j6lg0wypcc9uar5d2shs4p04xh",
                 network: :testnet, type: :base, payment: :script, stake: :script },
      type_04: { bech: "addr_test1gz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer5pnz75xxcrdw5vky",
                 network: :testnet, type: :pointer, payment: :key, stake: nil },
      type_05: { bech: "addr_test12rphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtupnz75xxcryqrvmw",
                 network: :testnet, type: :pointer, payment: :script, stake: nil },
      type_06: { bech: "addr_test1vz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzerspjrlsz",
                 network: :testnet, type: :enterprise, payment: :key, stake: nil },
      type_07: { bech: "addr_test1wrphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtcl6szpr",
                 network: :testnet, type: :enterprise, payment: :script, stake: nil },
      type_14: { bech: "stake_test1uqehkck0lajq8gr28t9uxnuvgcqrc6070x3k9r8048z8y5gssrtvn",
                 network: :testnet, type: :stake, payment: nil, stake: :key },
      type_15: { bech: "stake_test17rphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtcljw6kf",
                 network: :testnet, type: :stake, payment: nil, stake: :script }
    }.freeze

    [cip19_mainnet_addresses, cip19_testnet_addresses].each do |addresses|
      addresses.each do |name, addr|
        it "decodes CIP-19 #{addr[:network]} test vector #{name} correctly" do
          address = described_class.decode(addr[:bech])

          expect(address.network).to eq(addr[:network])
          expect(address.address_type).to eq(addr[:type])
          expect(address.payment_credential).to eq(addr[:payment])
          expect(address.stake_credential).to eq(addr[:stake])

          # verify correct subclass
          klass = addr[:type] == :stake ? described_class::Stake : described_class::Payment
          expect(address).to be_a(klass)
        end
      end
    end
  end
end
