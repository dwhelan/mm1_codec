defmodule MM1.CodecTest do
  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case

      test "decode" do
        assert decode(bytes()) === result()
      end

      test "encode" do
        assert encode(result()) === bytes()
      end
    end
  end
end
