defmodule MMS.ParameterTest do
  use MMS.CodecTest
  import MMS.TypedParameter

  codec_examples [
    {"q", << s(0), 1 >>, {:q, "00"} },
  ]
end
#      examples: [
#        { << s(0), 1 >>, {:q, "00"} },
#      ],
#       examples: [
#        # Input bytes  {Token,                      Codec}
#        {<< s(0)  >>, {:q,                         QValue}},
