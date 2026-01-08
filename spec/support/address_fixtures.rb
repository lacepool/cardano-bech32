# frozen_string_literal: true

# CIP-19 test vectors
# https://cips.cardano.org/cip/CIP-19#test-vectors

module AddressFixtures
  module Mainnet
    ADDRESSES = {
      type_00: { bech: "addr1qx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3n0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgse35a3x",
                 payload_bytes: [1, 148, 147, 49, 92, 217, 46, 181, 216, 196, 48, 78, 103, 183, 225, 106, 227, 109, 97, 211, 69, 2, 105, 70, 87, 129, 26, 44, 142, 51, 123, 98, 207, 255, 100, 3, 160, 106, 58, 203, 195, 79, 140, 70, 0, 60, 105, 254, 121, 163, 98, 140, 239, 169, 196, 114, 81],
                 network: :mainnet, type: :base, payment: :key, stake: :key },
      type_01: { bech: "addr1z8phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gten0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgs9yc0hh",
                 payload_bytes: [17, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47, 51, 123, 98, 207, 255, 100, 3, 160, 106, 58, 203, 195, 79, 140, 70, 0, 60, 105, 254, 121, 163, 98, 140, 239, 169, 196, 114, 81],
                 network: :mainnet, type: :base, payment: :script, stake: :key },
      type_02: { bech: "addr1yx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzerkr0vd4msrxnuwnccdxlhdjar77j6lg0wypcc9uar5d2shs2z78ve",
                 payload_bytes: [33, 148, 147, 49, 92, 217, 46, 181, 216, 196, 48, 78, 103, 183, 225, 106, 227, 109, 97, 211, 69, 2, 105, 70, 87, 129, 26, 44, 142, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47],
                 network: :mainnet, type: :base, payment: :key, stake: :script },
      type_03: { bech: "addr1x8phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gt7r0vd4msrxnuwnccdxlhdjar77j6lg0wypcc9uar5d2shskhj42g",
                 payload_bytes: [49, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47],
                 network: :mainnet, type: :base, payment: :script, stake: :script },
      type_04: { bech: "addr1gx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer5pnz75xxcrzqf96k",
                 payload_bytes: [65, 148, 147, 49, 92, 217, 46, 181, 216, 196, 48, 78, 103, 183, 225, 106, 227, 109, 97, 211, 69, 2, 105, 70, 87, 129, 26, 44, 142, 129, 152, 189, 67, 27, 3],
                 network: :mainnet, type: :pointer, payment: :key, stake: nil },
      type_05: { bech: "addr128phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtupnz75xxcrtw79hu",
                 payload_bytes: [81, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47, 129, 152, 189, 67, 27, 3],
                 network: :mainnet, type: :pointer, payment: :script, stake: nil },
      type_06: { bech: "addr1vx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzers66hrl8",
                 payload_bytes: [97, 148, 147, 49, 92, 217, 46, 181, 216, 196, 48, 78, 103, 183, 225, 106, 227, 109, 97, 211, 69, 2, 105, 70, 87, 129, 26, 44, 142],
                 network: :mainnet, type: :enterprise, payment: :key, stake: nil },
      type_07: { bech: "addr1w8phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtcyjy7wx",
                 payload_bytes: [113, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47],
                 network: :mainnet, type: :enterprise, payment: :script, stake: nil },
      type_14: { bech: "stake1uyehkck0lajq8gr28t9uxnuvgcqrc6070x3k9r8048z8y5gh6ffgw",
                 payload_bytes: [225, 51, 123, 98, 207, 255, 100, 3, 160, 106, 58, 203, 195, 79, 140, 70, 0, 60, 105, 254, 121, 163, 98, 140, 239, 169, 196, 114, 81],
                 network: :mainnet, type: :stake, payment: nil, stake: :key },
      type_15: { bech: "stake178phkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtcccycj5",
                 payload_bytes: [241, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47],
                 network: :mainnet, type: :stake, payment: nil, stake: :script }
    }.freeze
  end

  module Testnet
    ADDRESSES = {
      type_00: { bech: "addr_test1qz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3n0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgs68faae",
                 payload_bytes: [0, 148, 147, 49, 92, 217, 46, 181, 216, 196, 48, 78, 103, 183, 225, 106, 227, 109, 97, 211, 69, 2, 105, 70, 87, 129, 26, 44, 142, 51, 123, 98, 207, 255, 100, 3, 160, 106, 58, 203, 195, 79, 140, 70, 0, 60, 105, 254, 121, 163, 98, 140, 239, 169, 196, 114, 81],
                 network: :testnet, type: :base, payment: :key, stake: :key },
      type_01: { bech: "addr_test1zrphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gten0d3vllmyqwsx5wktcd8cc3sq835lu7drv2xwl2wywfgsxj90mg",
                 payload_bytes: [16, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47, 51, 123, 98, 207, 255, 100, 3, 160, 106, 58, 203, 195, 79, 140, 70, 0, 60, 105, 254, 121, 163, 98, 140, 239, 169, 196, 114, 81],
                 network: :testnet, type: :base, payment: :script, stake: :key },
      type_02: { bech: "addr_test1yz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzerkr0vd4msrxnuwnccdxlhdjar77j6lg0wypcc9uar5d2shsf5r8qx",
                 payload_bytes: [32, 148, 147, 49, 92, 217, 46, 181, 216, 196, 48, 78, 103, 183, 225, 106, 227, 109, 97, 211, 69, 2, 105, 70, 87, 129, 26, 44, 142, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47],
                 network: :testnet, type: :base, payment: :key, stake: :script },
      type_03: { bech: "addr_test1xrphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gt7r0vd4msrxnuwnccdxlhdjar77j6lg0wypcc9uar5d2shs4p04xh",
                 payload_bytes: [48, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47],
                 network: :testnet, type: :base, payment: :script, stake: :script },
      type_04: { bech: "addr_test1gz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer5pnz75xxcrdw5vky",
                 payload_bytes: [64, 148, 147, 49, 92, 217, 46, 181, 216, 196, 48, 78, 103, 183, 225, 106, 227, 109, 97, 211, 69, 2, 105, 70, 87, 129, 26, 44, 142, 129, 152, 189, 67, 27, 3],
                 network: :testnet, type: :pointer, payment: :key, stake: nil },
      type_05: { bech: "addr_test12rphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtupnz75xxcryqrvmw",
                 payload_bytes: [80, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47, 129, 152, 189, 67, 27, 3],
                 network: :testnet, type: :pointer, payment: :script, stake: nil },
      type_06: { bech: "addr_test1vz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzerspjrlsz",
                 payload_bytes: [96, 148, 147, 49, 92, 217, 46, 181, 216, 196, 48, 78, 103, 183, 225, 106, 227, 109, 97, 211, 69, 2, 105, 70, 87, 129, 26, 44, 142],
                 network: :testnet, type: :enterprise, payment: :key, stake: nil },
      type_07: { bech: "addr_test1wrphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtcl6szpr",
                 payload_bytes: [112, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47],
                 network: :testnet, type: :enterprise, payment: :script, stake: nil },
      type_14: { bech: "stake_test1uqehkck0lajq8gr28t9uxnuvgcqrc6070x3k9r8048z8y5gssrtvn",
                 payload_bytes: [224, 51, 123, 98, 207, 255, 100, 3, 160, 106, 58, 203, 195, 79, 140, 70, 0, 60, 105, 254, 121, 163, 98, 140, 239, 169, 196, 114, 81],
                 network: :testnet, type: :stake, payment: nil, stake: :key },
      type_15: { bech: "stake_test17rphkx6acpnf78fuvxn0mkew3l0fd058hzquvz7w36x4gtcljw6kf",
                 payload_bytes: [240, 195, 123, 27, 93, 192, 102, 159, 29, 60, 97, 166, 253, 219, 46, 143, 222, 150, 190, 135, 184, 129, 198, 11, 206, 142, 141, 84, 47],
                 network: :testnet, type: :stake, payment: nil, stake: :script }
    }.freeze
  end
end
