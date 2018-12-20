defmodule MMS.HeadersTestHelper do
  def header name, value do
    [{name, value}]
  end
end

defmodule MMS.HeadersTest do
  use ExUnit.Case
  import MMS.HeadersTestHelper
  alias MMS.Headers

  time_zero = DateTime.from_unix!(0)

  use MMS.TestExamples,
      codec: Headers,
      examples: [
        #{<<0x84, ... >>, header(MMS.ContentType, value)},
        {<<0x81, "@",   0        >>, header(MMS.Bcc,              "@"         )},
        {<<0x82, "@",   0        >>, header(MMS.Cc,               "@"         )},
        {<<0x83, "x",   0        >>, header(MMS.ContentLocation,  "x"         )},
        {<<0x85,   1,   0        >>, header(MMS.Date,             0           )},
        {<<0x86, 128             >>, header(MMS.DeliveryReport,   true        )},
        {<<0x87,   3, 128,   1, 0>>, header(MMS.DeliveryTime,     time_zero   )},
        {<<0x88,   3, 128,   1, 0>>, header(MMS.Expiry,           time_zero   )},
        {<<0x89,   3, 128, "@", 0>>, header(MMS.From,             "@"         )},
        {<<0x8a, 128             >>, header(MMS.MessageClass,     :personal   )},
        {<<0x8b, "@",   0        >>, header(MMS.MessageID,        "@"         )},
        {<<0x8c, 128             >>, header(MMS.MessageType,      :m_send_conf)},
        {<<0x8e,   1,   0        >>, header(MMS.MessageSize,      0           )},
        {<<0x8f, 128             >>, header(MMS.Priority,         :low        )},
        {<<0x8d, 128             >>, header(MMS.Version,          {0, 0}      )},
        {<<0x90, 128             >>, header(MMS.ReportAllowed,    true        )},
        {<<0x91, 128             >>, header(MMS.ResponseStatus,   :ok         )},
        {<<0x92, "x",   0        >>, header(MMS.ResponseText,     "x"         )},
        {<<0x93, 128             >>, header(MMS.SenderVisibility, :hide       )},
        {<<0x94, 128             >>, header(MMS.ReadReport,       true        )},
#        {<<0x95, 128             >>, header(MMS.Status, value)},
        #{<<0x96, ... >>, header(MMS.Subject, value)},
        #{<<0x97, ... >>, header(MMS.To, value)},
        #{<<0x98, ... >>, header(MMS.TransactionId, value)},
        #{<<0x99, ... >>, header(MMS.RetrieveStatus, value)},
        #{<<0x9a, ... >>, header(MMS.RetrieveText, value)},
        {<<0x9b, 128             >>, header(MMS.ReadStatus,       :read       )},
        #{<<0x9c, ... >>, header(MMS.ReplyCharging, value)},
        #{<<0x9d, ... >>, header(MMS.ReplyChargingDeadline, value)},
        #{<<0x9e, ... >>, header(MMS.ReplyChargingID, value)},
        #{<<0x9f, ... >>, header(MMS.ReplyChargingSize, value)},
        #{<<0xa0, ... >>, header(MMS.PreviouslySentBy, value)},
        #{<<0xa1, ... >>, header(MMS.PreviouslySentDate, value)},

        # Multiple headers
        {<<0x81, "@", 0, 0x82, "@", 0>>, [{MMS.Bcc, "@"}, {MMS.Cc, "@"}]},
      ]
end
