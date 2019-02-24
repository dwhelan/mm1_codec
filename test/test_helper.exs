ExUnit.start exclude: [:skip], include: [
  # Uncomment the line below to only run tests with: # @tag :focus
#     :focus], exclude: [:test
  ]


defmodule MMS.CodecTest do
  import OkError

  def s(short),  do: short + 128
  def l(length), do: length
  def u(value),  do: value |> MMS.Uint32.encode |> elem(1)

  def invalid_uint32 do
    <<128>>
  end

  def ok value, rest do
    ok {value, rest}
  end

  def assert_code_raise code do
    ExUnit.Assertions.assert_raise ArgumentError, fn -> Code.eval_string(code) end
  end

  defmacro __using__ _ do
    quote do
      use ExUnit.Case

      import MMS.DataTypes
      import OkError
      import MMS.Codec2
      import MMS.CodecTest
    end
  end

#  defmodule Ok do
#    def decode(<<byte , rest::binary>>), do: ok(byte, rest)
#    def encode(value),                   do: ok <<value>>
#  end
#
#  defmodule Error do
#    def decode(bytes), do: error(:data_type, bytes, :reason)
#    def encode(value), do: error(:data_type, value, :reason)
#  end
end
