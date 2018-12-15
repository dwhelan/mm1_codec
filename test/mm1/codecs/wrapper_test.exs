defmodule MM.Codecs2.Wrapper.WrapperTest do
  use ExUnit.Case

  alias MMS.ShortInteger

  import MM1.Codecs2.Wrapper

  wrap ShortInteger

  use MM1.Codecs2.TestExamples,
      examples: [
        {<<128>>, {{ShortInteger, 0}, <<>>}},
      ],

      decode_errors: [
        {<<127>>, {ShortInteger, :most_signficant_bit_must_be_1}},
      ],

      encode_errors: [
        {{ShortInteger, -1}, :must_be_an_integer_between_0_and_127},
      ]
end
