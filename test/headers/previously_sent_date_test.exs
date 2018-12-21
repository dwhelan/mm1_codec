defmodule MMS.PreviouslySentDateTest do
  use ExUnit.Case
  import MMS.DataTypes

  alias MMS.PreviouslySentDate

  length_quote = 31

  use MMS.TestExamples,
      codec: PreviouslySentDate,
      examples: [
        {<<3, 129, 1, 0        >>, {  1, 0}}, # short count
        {<<5,   2,   1, 0, 1, 0>>, {256, 0}}, # long count
      ],

      decode_errors: [
        {<<32>>,              :first_byte_must_be_less_than_32}, # length error
        {<<2, 32>>,           :invalid_integer},                 # count error
#        {<<5, 2, 1, 0, "@">>, :missing_terminator},              # address error
      ],

      encode_errors: [
        {{-1, "@"}, :invalid_integer},
      ]
end
