defmodule MMS.PreviouslySentByTest do
  use ExUnit.Case

  alias MMS.PreviouslySentBy

  use MMS.TestExamples,
      codec: PreviouslySentBy,
      examples: [
        {<<3, 129, "@", 0        >>, {"@",   1} }, # short count
        {<<5,   2,   1, 0, "@", 0>>, {"@", 256} }, # long count
      ],

      decode_errors: [
        {<<32>>,              :invalid_length},     # length error
        {<<2, 32>>,           :invalid_integer},    # count error
        {<<5, 2, 1, 0, "@">>, :invalid_encoded_string}, # address error
      ],

      encode_errors: [
        { {"@", -1}, :invalid_integer},
      ]
end
