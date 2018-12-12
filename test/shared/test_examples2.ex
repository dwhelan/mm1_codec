defmodule MM1.Codecs2.TestExamples do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec          opts[:codec]         || __MODULE__
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      encode_errors = opts[:encode_errors] || []

      Enum.each(examples, fn {bytes, result} ->
        @bytes  bytes
        @result result

        test "decode #{inspect bytes} === {:ok, {#{inspect result}}}" do
          assert @codec.decode(@bytes) === {:ok, @result}
        end

        test "encode #{inspect result} === {:ok, #{inspect bytes}}" do
          {value, rest} = @result
          assert @codec.encode(value) === {:ok, @bytes}
        end
      end)

      Enum.each(decode_errors, fn {bytes, reason} ->
        @bytes  bytes
        @reason reason

        test "decode #{inspect bytes} => {:error, #{inspect reason}}" do
          assert @codec.decode(@bytes) === {:error, @reason}
        end
      end)

      Enum.each(encode_errors, fn {value, reason} ->
        @value  value
        @reason reason

        test "encode #{inspect value} => {:error, #{inspect reason}}" do
          assert @codec.encode(@value) === {:error, @reason}
        end
      end)
    end
  end
end
