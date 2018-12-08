defmodule MM.Codecs2.Wrapper.WrapperTest do
  use ExUnit.Case

  alias WAP2.ShortInteger

  import MM1.Codecs2.Wrapper

  wrap ShortInteger

  use MM1.Codecs2.TestExamples,
      examples: [
        {<<128>>, {0, ShortInteger}},
      ],

      decode_errors: [
        {<<127>>, {:most_signficant_bit_must_be_1, ShortInteger}},
      ],

      encode_errors: [
        {{-1, ShortInteger}, :must_be_an_integer_between_0_and_127},
      ]
end
