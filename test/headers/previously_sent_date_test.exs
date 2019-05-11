defmodule MMS.PreviouslySentDateTest do
  use MMS.CodecTest
  import MMS.PreviouslySentDate

  time_zero = DateTime.from_unix! 0
  negative_time = DateTime.from_unix! -1

  codec_examples [
    #               _            <- length
    #                  ___       <- forwarded count
    #                       ____ <- date
    {"sent data", <<3, 129, 1, 0>>, {time_zero,   1} }, # short count
  ]

  decode_errors [
    {"value length", <<1, 129, 1, 0>>,},
    {"count",        <<1, 0, 1, 0>>,},
    {"date",         <<5, 2, 1, 0, "@">> },
  ]

  encode_errors [
    {"date", {negative_time, 1}},
    {"count", {time_zero, -1}},
  ]
end
