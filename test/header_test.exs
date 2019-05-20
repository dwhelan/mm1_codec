defmodule MMS.HeaderTest do
  use MMS.CodecTest
  import MMS.Header

  date_time_zero = DateTime.from_unix! 0

  codec_examples [
    {"bcc",                     <<s(1),  "a\0">>,               {:bcc,                     {"a", ""}}},
    {"cc",                      <<s(2),  "a\0">>,               {:cc,                      {"a", ""}}},
    {"content_location",        <<s(3),  "x\0">>,               {:content_location,        "x"}},
    {"content_type",            <<s(4),  s(0)>>,                {:content_type,            0}},
    {"date",                    <<s(5),  l(1), 0>>,             {:date,                    date_time_zero}},
    {"delivery_report",         <<s(6),  s(0)>>,                {:delivery_report,         true}},
    {"delivery_time",           <<s(7),  l(3), s(0), l(1), 0>>, {:delivery_time,           date_time_zero}},
    {"expiry",                  <<s(8),  l(3), s(0), l(1), 0>>, {:expiry,                  date_time_zero}},
    {"from",                    <<s(9),  l(3), s(0), "a\0">>,   {:from,                    {"a", ""}}},
    {"message_class",           <<s(10), s(0)>>,                {:message_class,           :personal}},
    {"message_id",              <<s(11), "a\0">>,               {:message_id,              "a"}},
    {"message_type",            <<s(12), s(0)>>,                {:message_type,            :m_send_req}},
    {"version",                 <<s(13), 0b10000000>>,          {:version,                 {0, 0}}},
    {"message_size",            <<s(14), l(1), 0>>,             {:message_size,            0}},
    {"priority",                <<s(15), s(0)>>,                {:priority,                :low}},
    {"report_allowed",          <<s(16), s(0)>>,                {:report_allowed,          true}},
    {"response_status",         <<s(17), s(0)>>,                {:response_status,         :ok}},
    {"response_text",           <<s(18), "a\0">>,               {:response_text,           "a"}},
    {"sender_visibility",       <<s(19), s(0)>>,                {:sender_visibility,       :hide}},
    {"read_report",             <<s(20), s(0)>>,                {:read_report,             true}},
    {"status",                  <<s(21), s(0)>>,                {:status,                  :expired}},
    {"subject",                 <<s(22), "a\0">>,               {:subject,                 "a"}},
    {"to",                      <<s(23), "a\0">>,               {:to,                      "a"}},
    {"transaction_id",          <<s(24), "a\0">>,               {:transaction_id,          "a"}},
    {"retrieve_status",         <<s(25), s(0)>>,                {:retrieve_status,         :ok}},
    {"retrieve_text",           <<s(26), "a\0">>,               {:retrieve_text,           "a"}},
    {"read_status",             <<s(27), s(0)>>,                {:read_status,             :read}},
    {"reply_charging",          <<s(28), s(0)>>,                {:reply_charging,          :requested}},
    {"reply_charging_deadline", <<s(29), l(3), s(0), l(1), 0>>, {:reply_charging_deadline, date_time_zero}},
    {"reply_charging_id",       <<s(30), "a\0">>,               {:reply_charging_id,       "a"}},
    {"reply_charging_size",     <<s(31), l(1), 0>>,             {:reply_charging_size,     0}},
    {"previously_sent_by",      <<s(32), l(3), s(2), "a\0">>,   {:previously_sent_by,      {{"a", ""}, 2}}},
    {"previously_sent_date",    <<s(33), l(3), s(2), l(1), 0>>, {:previously_sent_date,    {date_time_zero, 2}}},
  ]

  decode_errors [
    { "too small",       <<s(0), 0>>,  :out_of_range},
    { "too big",         <<s(34), 0>>, :out_of_range},
    { "header decoding", <<s(1), "">>, address: :no_bytes},
  ]

  encode_errors [
    { "invalid data type", {:invalid, :header},   :out_of_range},
    { "header encoding",   {:bcc, "\0"}, address: :out_of_range},
  ]
end
