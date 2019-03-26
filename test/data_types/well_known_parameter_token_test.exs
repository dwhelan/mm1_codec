defmodule MMS.WellKnownParameterTokenTest do
  use MMS.CodecTest

  alias MMS.WellKnownParameterToken

  use MMS.TestExamples,
      codec: WellKnownParameterToken,

      examples: [
        # Input bytes  {Token,                      Codec}
        {<< s(0)  >>, :q },
        {<< s(1)  >>, :charset },
        {<< s(2)  >>, :level },
        {<< s(3)  >>, :type },
        {<< s(5)  >>, :"name (deprecated)" },
        {<< s(6)  >>, :"file_name (deprecated)" },
        {<< s(7)  >>, :differences },
        {<< s(8)  >>, :padding },
        {<< s(9)  >>, :type_multipart },
        {<< s(10) >>, :"start (deprecated)" },
        {<< s(11) >>, :"start_info (deprecated)" },
        {<< s(12) >>, :"comment (deprecated)" },
        {<< s(13) >>, :"domain (deprecated)" },
        {<< s(14) >>, :max_age },
        {<< s(15) >>, :"path (deprecated)" },
        {<< s(16) >>, :secure },
        {<< s(17) >>, :sec },
        {<< s(18) >>, :mac },
        {<< s(19) >>, :creation_date },
        {<< s(20) >>, :modification_date },
        {<< s(21) >>, :read_date },
        {<< s(22) >>, :size },
        {<< s(23) >>, :name },
        {<< s(24) >>, :file_name },
        {<< s(25) >>, :start },
        {<< s(26) >>, :start_info },
        {<< s(27) >>, :comment },
        {<< s(28) >>, :domain },
        {<< s(29) >>, :path },
      ],

      encode_errors: [
#        {[x: ""], {:x, :known_parameter}},
      ]

end
