defmodule MMS.LookupWithMapTest do
  use MMS.CodecTest

  use MMS.Lookup, map: %{0 => false, 1 => true}

  use MMS.TestExamples,
      examples: [
        { << s(0) >>, false },
        { << s(1) >>, true  },
      ],

      decode_errors: [
        { << s(-1) >>, :lookup_with_map_test },
        { << s(2)  >>, :lookup_with_map_test },
      ],

      encode_errors: [
        { :_, :lookup_with_map_test },
      ]
end

defmodule MMS.LookupWithValuesTest do
  use MMS.CodecTest

  use MMS.Lookup, values: [false, true]

  use MMS.TestExamples,
      examples: [
        { << s(0) >>, false },
        { << s(1) >>, true  },
      ],

      decode_errors: [
        { <<127>>, :lookup_with_values_test },
        { <<130>>, :lookup_with_values_test },
      ],

      encode_errors: [
        {-1, :lookup_with_values_test},
      ]
end
