defmodule MM1.Codecs.ComposerTest do
  use ExUnit.Case

  alias WAP.ShortInteger

  use MM1.Codecs.Composer

  def codecs do
    [ShortInteger, ShortInteger, ShortInteger]
  end

  use MM1.Codecs.TestExamples,
      examples: [
        {<<128, 129, 130>>, [0, 1, 2]}
      ],

      decode_errors: [
        {<<  2, 129, 130>>, [:most_signficant_bit_must_be_1],           [<<2>>],       <<2>>          },
        {<<128,   2, 130>>, [nil, :most_signficant_bit_must_be_1],      [0, <<2>>] ,   <<128, 2>>     },
        {<<128, 129,   2>>, [nil, nil, :most_signficant_bit_must_be_1], [0, 1, <<2>>], <<128, 129, 2>>},
      ],

      new_errors: [
        { [-1,  1,  2], [:must_be_an_integer_between_0_and_127, nil, nil], <<>>        },
        { [ 0, -1,  2], [nil, :must_be_an_integer_between_0_and_127, nil], <<128>>     },
        { [ 0,  1, -1], [nil, nil, :must_be_an_integer_between_0_and_127], <<128, 129>>},

        { [ 0,  1],     :incorrect_list_length},
        { :not_a_list,  :must_be_a_list       },
      ]
end

defmodule MM1.Codecs2.ComposerTest do
  use ExUnit.Case

  alias WAP2.ShortInteger

  import MM1.Codecs2.Composer

  compose [ShortInteger, ShortInteger, ShortInteger]

  use MM1.Codecs2.TestExamples,
      examples: [
        {<<128, 129, 130>>, [0, 1, 2]},
      ],

      decode_errors: [
        {<<  0, 129, 130>>, {:most_signficant_bit_must_be_1, 0}},
        {<<128,   0, 130>>, {:most_signficant_bit_must_be_1, 1}},
        {<<128, 129,   0>>, {:most_signficant_bit_must_be_1, 2}},
      ],

      encode_errors: [
        { [-1,  1,  2], {:must_be_an_integer_between_0_and_127, 0}},
        { [ 0, -1,  2], {:must_be_an_integer_between_0_and_127, 1}},
        { [ 0,  1, -1], {:must_be_an_integer_between_0_and_127, 2}},

        { [ 0,  1],     :incorrect_list_length},
        { :not_a_list,  :must_be_a_list       },
      ]
end
