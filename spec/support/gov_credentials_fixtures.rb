# frozen_string_literal: true

module GovCredentialFixtures
  CC_HOT_CREDENTIAL = {
    hrp: "cc_hot",
    bech32: "cc_hot1qgqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqvcdjk7",
    hash_bytes: [0x00] * 28,
    hash_hex: "00000000000000000000000000000000000000000000000000000000",
    header_byte: 0x02,
    payload_bytes: [0x02] + ([0x00] * 28),
    payload_hex: "0200000000000000000000000000000000000000000000000000000000",
    credential: :cc_hot,
    key_type: :key
  }.freeze

  CC_COLD_CREDENTIAL = {
    hrp: "cc_cold",
    bech32: "cc_cold1zvqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6kflvs",
    hash_bytes: [0x00] * 28,
    hash_hex: "00000000000000000000000000000000000000000000000000000000",
    header_byte: 0x13,
    payload_bytes: [0x13] + ([0x00] * 28),
    payload_hex: "1300000000000000000000000000000000000000000000000000000000",
    credential: :cc_cold,
    key_type: :script
  }.freeze

  DREP_CREDENTIAL = {
    hrp: "drep",
    bech32: "drep1ygqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq7vlc9n",
    hash_bytes: [0x00] * 28,
    hash_hex: "00000000000000000000000000000000000000000000000000000000",
    header_byte: 0x22,
    payload_bytes: [0x22] + ([0x00] * 28),
    payload_hex: "2200000000000000000000000000000000000000000000000000000000",
    credential: :drep,
    key_type: :key
  }.freeze

  GOV_ACTION = {
    hrp: "gov_action",
    bech32: "gov_action1k2jertppnnndejjcglszfqq4yzw8evzrd2nt66rr6rqlz54xp0zsq05ecsn",
    txref: "b2a591ac219ce6dcca5847e0248015209c7cb0436aa6bd6863d0c1f152a60bc5#0",
    tx_id: "b2a591ac219ce6dcca5847e0248015209c7cb0436aa6bd6863d0c1f152a60bc5",
    index: 0
  }.freeze
end
