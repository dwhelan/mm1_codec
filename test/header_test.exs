defmodule MMS.HeaderTest do
  use MMS.CodecTest
  import MMS.Header

  date_time_zero = DateTime.from_unix! 0

  codec_examples [
    {"bcc",                          <<s(1),  "@\0">>,               {:bcc,                     {"@", ""}}},
    {"cc",                           <<s(2),  "@\0">>,               {:cc,                      {"@", ""}}},
    {"content_location",             <<s(3),  "x\0">>,               {:content_location,        "x"}},
    {"content_type",                 <<s(4),  s(0)>>,                {:content_type,            0}},
    {"date",                         <<s(5),  l(1), 0>>,             {:date,                    date_time_zero}},
    {"delivery_report",              <<s(6),  s(0)>>,                {:delivery_report,         true}},
    {"delivery_time",                <<s(7),  l(3), s(0), l(1), 0>>, {:delivery_time,           date_time_zero}},
    {"expiry",                       <<s(8),  l(3), s(0), l(1), 0>>, {:expiry,                  date_time_zero}},
    {"from",                         <<s(9),  l(3), s(0), "@\0">>,   {:from,                    {"@", ""}}},
    {"message_class",                <<s(10), s(0)>>,                {:message_class,           :personal}},
    {"message_id",                   <<s(11), "x\0">>,               {:message_id,              "x"}},
    {"message_type",                 <<s(12), s(0)>>,                {:message_type,            :m_send_req}},
    {"version",                      <<s(13), 0b10000000>>,          {:version,                 {0, 0}}},
    {"message_size",                 <<s(14), l(1), 0>>,             {:message_size,            0}},
    {"priority",                     <<s(15), s(0)>>,                {:priority,                :low}},
    {"report_allowed",               <<s(16), s(0)>>,                {:report_allowed,          true}},
    {"response_status",              <<s(17), s(0)>>,                {:response_status,         :ok}},
    {"response_text",                <<s(18), "x\0">>,               {:response_text,           "x"}},
    {"sender_visibility",            <<s(19), s(0)>>,                {:sender_visibility,       :hide}},
    {"read_report",                  <<s(20), s(0)>>,                {:read_report,             true}},
    {"status",                       <<s(21), s(0)>>,                {:status,                  :expired}},
    {"subject",                      <<s(22), "x\0">>,               {:subject,                 "x"}},
    {"to",                           <<s(23), "x\0">>,               {:to,                      "x"}},
    {"transaction_id",               <<s(24), "x\0">>,               {:transaction_id,          "x"}},
    {"retrieve_status",              <<s(25), s(0)>>,                {:retrieve_status,         :ok}},
    {"retrieve_text",                <<s(26), "x\0">>,               {:retrieve_text,           "x"}},
    {"read_status",                  <<s(27), s(0)>>,                {:read_status,             :read}},
    {"reply_charging",               <<s(28), s(0)>>,                {:reply_charging,          :requested}},
    {"reply_charging_deadline",      <<s(29), l(3), s(0), l(1), 0>>, {:reply_charging_deadline, date_time_zero}},
    {"reply_charging_id",            <<s(30), "x\0">>,               {:reply_charging_id,       "x"}},
    {"reply_charging_size",          <<s(31), l(1), 0>>,             {:reply_charging_size,     0}},
    {"previously_sent_by",           <<s(32), l(3), s(2), "@\0">>,   {:previously_sent_by,      {{"@", ""}, 2}}},
    {"previously_sent_date",         <<s(33), l(3), s(2), l(1), 0>>, {:previously_sent_date,    {date_time_zero, 2}}},
  ]

  encode_errors [
    { "", [not_a_header: "x"], {:not_a_header, :header}},
  ]
end
