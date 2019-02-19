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
        {<<32>>,              {:value_length, " ", :does_not_start_with_a_short_length_or_length_quote}}, # length error
        {<<2, 32>>,           {:short_length, <<2, 32>>, %{available_bytes: 1, length: 2}}},                 # count error
#        {<<5, 2, 1, 0, "@">>, :missing_end_of_string_byte},              # date error
      ],

      encode_errors: [
        {{DateTime.from_unix!(-1), 1}},
        {{time_zero, -1}            },
      ]
end
