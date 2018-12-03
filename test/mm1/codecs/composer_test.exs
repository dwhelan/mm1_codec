defmodule MM1.Codecs.ComposerTest do
  use ExUnit.Case

  alias WAP.ShortInteger

  use MM1.Codecs.Composer, codecs: [ShortInteger, ShortInteger, ShortInteger]

  use MM1.Codecs.BaseExamples,
      examples: [
        {<<128, 129, 130>>, [0, 1, 2]}
      ],

      decode_errors2: [
        {<<  2, 129, 130>>, [:most_signficant_bit_must_be_1],           [<<2>>],       <<2>>},
        {<<128,   2, 130>>, [nil, :most_signficant_bit_must_be_1],      [0, <<2>>] ,   <<128, 2>>},
        {<<128, 129,   2>>, [nil, nil, :most_signficant_bit_must_be_1], [0, 1, <<2>>], <<128, 129, 2>>},
      ],

      new_errors2: [
        { [-1,  1,  2], [:must_be_an_integer_between_0_and_127, nil, nil], <<>>},
        { [ 0, -1,  2], [nil, :must_be_an_integer_between_0_and_127, nil], <<128>>},
        { [ 0,  1, -1], [nil, nil, :must_be_an_integer_between_0_and_127], <<128, 129>>},
        { [ 0,  1],     :incorrect_list_length, <<>>},
        { :not_a_list,  :must_be_a_list, <<>>},
      ]
end
