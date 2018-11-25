defmodule MM1.MessageTest do
  use ExUnit.Case
  import MM1.CodecExamples

  alias MM1.{Result, Headers, Message, Bcc, Cc}
  import Message

  test "decode" do
    assert decode(<<129, 0, 130, 0>>) == %Result{
             module: Message,
             value: %Result{
               module: Headers,
               value: [
                 %Result{bytes: <<129, 0>>, module: Bcc, value: "", rest: <<130, 0>>},
                 %Result{bytes: <<130, 0>>, module: Cc,  value: ""}
               ]
             }
           }
  end

  test "encode" do
    assert encode(%Result{
             module: Message,
             value: %Result{
               module: Headers,
               value: [
                 %Result{bytes: <<129, 0>>, module: Bcc, value: "", rest: <<130, 0>>},
                 %Result{bytes: <<130, 0>>, module: Cc,  value: ""}
               ]
             }
           }) == <<129, 0, 130, 0>>
  end

  test "new" do
    assert new([
             %Result{module: Bcc, value: ""},
             %Result{module: Cc,  value: ""}
           ]) == %Result{
             module: Message,
             value: %Result{
               module: Headers,
               value: [
                 %Result{bytes: <<129, 0>>, module: Bcc, value: ""},
                 %Result{bytes: <<130, 0>>, module: Cc,  value: ""}
               ]
             }
           }
  end
end
