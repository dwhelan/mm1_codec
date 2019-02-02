defmodule MMS.QValue.Test do
  use MMS.Test2

  import MMS.QValue

  describe "decode" do
    test "00",  do: assert decode(u 1)    == ok "00",  <<>>
    test "99",  do: assert decode(u 100)  == ok "99",  <<>>
    test "001", do: assert decode(u 101)  == ok "001", <<>>
    test "999", do: assert decode(u 1099) == ok "999", <<>>

    test "<<>>",    do: assert decode(<<>>)        == error code: :insufficient_bytes, bytes: <<>>
    test "<<0>>",   do: assert decode(<<0>>)       == error code: :invalid_q_value,    bytes: <<0>>,        value: 0
    test "<<128>>", do: assert decode(<<128>>)     == error code: :invalid_q_value,    bytes: <<128>>,      nested: :invalid_uint32
    test "1100",    do: assert decode(u 1100) == error code: :invalid_q_value,    bytes: u(1100), value: 1100
  end

  describe "encode" do
    test "00",  do: assert encode("00")  == ok u(1)
    test "99",  do: assert encode("99")  == ok u(100)
    test "001", do: assert encode("001") == ok u(101)
    test "999", do: assert encode("999") == ok u(1099)

    test "0",    do: assert encode("0")    == error code: :invalid_q_value, value: "0"
    test "1000", do: assert encode("1000") == error code: :invalid_q_value, value: "1000"
    test "abcd", do: assert encode("abcd") == error code: :invalid_q_value, value: "abcd"
  end
end
