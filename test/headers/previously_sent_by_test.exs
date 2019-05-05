defmodule MMS.PreviouslySentByTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.PreviouslySentBy,

      examples: [
        { << l(3), s(1), "@\0" >>,       {{"@", ""}, 1  } }, # short count
        { << l(5), l(2), 1, 0, "@\0" >>, {{"@", ""}, 256} }, # long count
      ],

      decode_errors: [
        { << 32 >>,                    {:value_length, << 32 >>, [short_length: [out_of_range: 32], quoted_length: :does_not_start_with_a_length_quote]}  },
        { << 2, 32 >>,                 {:value_length, <<2, 32>>, [{:short_length, [required_bytes: 2, available_bytes: 1]}, {:quoted_length, :does_not_start_with_a_length_quote}]}},
        { << l(4), l(2), 1, 0, "@" >>, {:value_length_list, <<4, 2, 1, 0, 64>>, [:list, %{error: {:address, "@", [:text, :missing_end_of_string]}, length: 4, values: [256]}]} },
      ],

      encode_errors: [
        { {"@", -1}, {:list, [-1, "@"], {:integer_value, -1, [short_integer: :out_of_range, long_integer: :out_of_range]}} },
      ]
end
