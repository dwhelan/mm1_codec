defmodule MMS.PreviouslySentByTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.PreviouslySentBy,

      examples: [
        { << l(3), s(1), "@\0" >>,       {"@", 1  } }, # short count
        { << l(5), l(2), 1, 0, "@\0" >>, {"@", 256} }, # long count
      ],

      decode_errors: [
        { << 32 >>,                    :invalid_value_length  }, # length error
        { << 2, 32 >>,                 :invalid_value_length }, # count error
        { << l(5), l(2), 1, 0, "@" >>, :invalid_value_length  }, # address error -> missing terminator
      ],

      encode_errors: [
        { {"@", -1}, :invalid_integer },
      ]
end
