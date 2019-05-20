defmodule MMS.PreviouslySentDateTest do
  use MMS.CodecTest
  import MMS.PreviouslySentDate

  time_zero = DateTime.from_unix! 0
  negative_time = DateTime.from_unix! -1

  codec_examples [
    #               _             <- length
    #                  ____       <- forwarded count
    #                        ____ <- date
    {"sent date", <<3, s(1), 1, 0>>, {1, time_zero} }, # short count
  ]

  decode_errors [
    {"invalid length",   <<1, s(1), 1, 0>>,},
    {"invalid count",    <<3, s(-1), 1, 0>>,},
    {"invalid date",     <<5, s(1), 1, 0, "@">> },
  ]

  encode_errors [
    {"date",  {negative_time, 1}},
    {"count", {time_zero, -1}},
  ]
end
