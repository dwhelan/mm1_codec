defmodule MMS.QValue.Test do
  use MMS.CodecTest

  import MMS.QValue

  describe "decode" do
    test "u 1    -> 00",  do: assert decode(u 1)    == ok "00",  <<>>
    test "u 100  -> 99",  do: assert decode(u 100)  == ok "99",  <<>>
    test "u 101  -> 001", do: assert decode(u 101)  == ok "001", <<>>
    test "u 1099 -> 999", do: assert decode(u 1099) == ok "999", <<>>

    test "<<>>",    do: assert decode(<<>>)    == error :qvalue, <<>>,    :no_bytes
    test "<<128>>", do: assert decode(<<128>>) == error :qvalue, <<128>>, [:uintvar_integer, :first_byte_cannot_be_128]
    test "u 0",     do: assert decode(u 0)     == error :qvalue, u(0),    %{out_of_range: 0}
    test "u 1100",  do: assert decode(u 1100)  == error :qvalue, u(1100), %{out_of_range: 1100}
  end

  describe "encode" do
    test "00",  do: assert encode("00")  == ok u(1)
    test "99",  do: assert encode("99")  == ok u(100)
    test "001", do: assert encode("001") == ok u(101)
    test "999", do: assert encode("999") == ok u(1099)

    test "0",    do: assert encode("0")    == error :qvalue, "0",    :must_be_string_of_2_or_3_digits
    test "1000", do: assert encode("1000") == error :qvalue, "1000", :must_be_string_of_2_or_3_digits
    test "ab",   do: assert encode("ab")   == error :qvalue, "ab",   :must_be_string_of_2_or_3_digits
    test "abc",  do: assert encode("abc")  == error :qvalue, "abc",  :must_be_string_of_2_or_3_digits
  end
end
