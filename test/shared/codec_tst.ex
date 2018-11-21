defmodule MM1.CodecTest do
  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case

      describe "base decode" do
        test "valid bytes" do
          assert decode(bytes()) === result()
        end

        test "insufficient bytes" do
          assert %MM1.Result{value: {:err, :insufficient_bytes}, bytes: <<>>, rest: <<>>} = decode <<>>
        end
      end

      describe "base encode" do
        test "valid result " do
          assert encode(result()) === bytes()
        end
      end
    end
  end
end
