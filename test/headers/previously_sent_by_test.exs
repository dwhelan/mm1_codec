defmodule MMS.PreviouslySentByTest do
  use ExUnit.Case
  import MMS.DataTypes

  alias MMS.PreviouslySentBy

  length_quote = 31

  use MMS.TestExamples,
      codec: PreviouslySentBy,
      examples: [
        {<<3, 129, "@", 0        >>, {  1, "@"}}, # short count
        {<<5,   2,   1, 0, "@", 0>>, {256, "@"}}, # long count
      ],

      decode_errors: [
        {<<32>>,              :first_byte_must_be_less_than_32}, # length error
        {<<2, 32>>,           :invalid_integer},                 # count error
        {<<5, 2, 1, 0, "@">>, :missing_terminator},              # address error
      ],

      encode_errors: [
        {{-1, "@"}, :invalid_integer},
      ]
end
