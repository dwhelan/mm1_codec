defmodule MMS.PreviouslySentDateTest do
  use ExUnit.Case

  alias MMS.PreviouslySentDate

  time_zero = DateTime.from_unix! 0

  use MMS.TestExamples,
      codec: PreviouslySentDate,
      examples: [
        #  _                  <- length
        #     _________       <- forwarded count
        #                ____ <- date
        {<<3, 129,       1, 0>>, {time_zero,   1} }, # short count
        {<<5,   2, 1, 0, 1, 0>>, {time_zero, 256} }, # long count
      ],

      decode_errors: [
        {<<32>>,              :invalid_length}, # length error
        {<<2, 32>>,           :invalid_length},                 # count error
#        {<<5, 2, 1, 0, "@">>, :missing_terminator},              # date error
      ],

      encode_errors: [
        {{DateTime.from_unix!(-1), 1}},
        {{time_zero, -1}            },
      ]
end
