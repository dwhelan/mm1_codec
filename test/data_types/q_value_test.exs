defmodule QValue.DecodeTest do
  use DecodeTest

  import MMS.QValue.Decode

  test "00",  do: assert decode(uint32 1)    == ok "00",  <<>>
  test "99",  do: assert decode(uint32 100)  == ok "99",  <<>>
  test "001", do: assert decode(uint32 101)  == ok "001", <<>>
  test "999", do: assert decode(uint32 1099) == ok "999", <<>>

  test "<<>>",    do: assert decode(<<>>)        == error :insufficient_bytes, <<>>
  test "<<0>>",   do: assert decode(<<0>>)       == error :invalid_q_value, <<0>>, 0
  test "<<128>>", do: assert decode(<<128>>)     == error :invalid_q_value, <<128>>, :invalid_uint32
  test "1100",    do: assert decode(uint32 1100) == error :invalid_q_value, uint32(1100), 1100
end

defmodule QValue.EncodeTest do
  use EncodeTest

  import MMS.QValue.Encode

  test "00",  do: assert encode("00")  == ok uint32(1)
  test "99",  do: assert encode("99")  == ok uint32(100)
  test "001", do: assert encode("001") == ok uint32(101)
  test "999", do: assert encode("999") == ok uint32(1099)

  test "0",    do: assert encode("0")    == error :invalid_q_value, "0"
  test "1000", do: assert encode("1000") == error :invalid_q_value, "1000"
  test "abcd", do: assert encode("abcd") == error :invalid_q_value, "abcd"
end
