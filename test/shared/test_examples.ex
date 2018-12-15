defmodule MMS.TestExamples do
  def text value do
    value |> Kernel.inspect |> String.slice(0..40)
  end

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import MMS.TestExamples

      @codec          opts[:codec]         || __MODULE__
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      encode_errors = opts[:encode_errors] || []

      Enum.each(examples, fn {bytes, result} ->
        @bytes  bytes
        @result result

        test "decode #{text @bytes} === {:ok, {#{text result}}}" do
          assert @codec.decode(@bytes) === {:ok, @result}
        end

        test "encode #{text result} === {:ok, #{text @bytes}" do
          {value, rest} = @result
          assert @codec.encode(value) === {:ok, @bytes}
        end
      end)

      Enum.each(decode_errors, fn {bytes, reason} ->
        @bytes  bytes
        @reason reason

        test "decode #{text @bytes} => {:error, #{text reason}}" do
          assert @codec.decode(@bytes) === {:error, @reason}
        end
      end)

      Enum.each(encode_errors, fn {value, reason} ->
        @value  value
        @reason reason

        test "encode #{text value} => {:error, #{text reason}}" do
          assert @codec.encode(@value) === {:error, @reason}
        end
      end)
    end
  end
end
