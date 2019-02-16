defmodule MMS.PreviouslySentByTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.PreviouslySentBy,

      examples: [
        { << l(3), s(1), "@\0" >>,       {"@", 1  } }, # short count
        { << l(5), l(2), 1, 0, "@\0" >>, {"@", 256} }, # long count
      ],

      decode_errors: [
        { << 32 >>,                    {:invalid_value_length, " ", :does_not_start_with_a_short_length_or_length_quote}  }, # length error
        { << 2, 32 >>,                 {:invalid_short_length, <<2, 32>>, {:insufficient_bytes, 2}} }, # count error
        { << l(4), l(2), 1, 0, "@" >>, {:invalid_address, "@", {:invalid_text, "@", :missing_end_of_string_0_byte}}  }, # address error -> missing terminator
      ],

      encode_errors: [
        { {"@", -1}, :invalid_integer },
      ]
end
