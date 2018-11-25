defmodule MM1.WrapperCodeTest do
  use ExUnit.Case

  alias WAP.Byte
  alias MM1.Result

  use MM1.WrapperCodec, codec: Byte

  test "decode" do
    assert decode(<<0, "rest">>) == %Result{
             module: __MODULE__,
             bytes: <<>>,
             rest: "rest",
             value: %Result{
               module: Byte,
               bytes: <<0>>,
               value: 0,
               rest: "rest"
             }
           }
  end

  test "encode" do
    assert encode(
             %Result{
               module: __MODULE__,
               bytes: <<>>,
               rest: "rest",
               value: %Result{
                 module: Byte,
                 bytes: <<0>>,
                 value: 0,
                 rest: "rest"
               }
             }
           ) == <<0>>
  end

  test "new" do
    assert new(0) == %Result{
             module: __MODULE__,
             bytes: <<>>,
             rest: <<>>,
             value: %Result{
               module: Byte,
               bytes: <<0>>,
               value: 0,
               rest: <<>>
             }
           }
  end
end
