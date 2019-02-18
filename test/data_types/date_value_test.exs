defmodule MMS.DateValueTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.DateValue,

      examples: [
        { << l(1), 0>>,   DateTime.from_unix! 0   },
        { << l(1), 127>>, DateTime.from_unix! 127 },
      ],

      decode_errors: [
        {<<32>>,     {:invalid_date_value, <<32>>, [:invalid_long, :invalid_short_length, 32]} },

        {<<l(2), 32>>,  {:invalid_date_value,  <<l(2), 32>>, [:invalid_long, :invalid_short_length, %{length: 2, available_bytes: 1}]} },
      ],

      encode_errors: [
        {DateTime.from_unix!(-1), {:invalid_date_value, DateTime.from_unix!(-1), :cannot_be_before_1970}},
      ]

  import MMS.DateValue

  describe "compress_details" do
    test "should remove value" do
      assert compress_details({:code, :value, :details}) == [:code, :details]
    end

    test "should apply recursively" do
      assert compress_details({:code, :value, {:code2, :value2, :details2}}) == [:code, :code2, :details2]
    end
  end
end
