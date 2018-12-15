defmodule MM1.Codecs.TestExamples do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      import Kernel, except: [inspect: 1]
      import MM1.Codecs.Test

      @codec          opts[:codec]         || __MODULE__
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      encode_errors = opts[:encode_errors] || []

      Enum.each(examples, fn {bytes, result} ->
        @bytes  bytes
        @result result

        test "decode #{inspect2 @bytes} === {:ok, {#{inspect2 result}}}" do
          assert @codec.decode(@bytes) === {:ok, @result}
        end

        test "encode #{inspect2 result} === {:ok, #{inspect2 @bytes}" do
          {value, rest} = @result
          assert @codec.encode(value) === {:ok, @bytes}
        end
      end)

      Enum.each(decode_errors, fn {bytes, reason} ->
        @bytes  bytes
        @reason reason

        test "decode #{inspect2 @bytes} => {:error, #{inspect2 reason}}" do
          assert @codec.decode(@bytes) === {:error, @reason}
        end
      end)

      Enum.each(encode_errors, fn {value, reason} ->
        @value  value
        @reason reason

        test "encode #{inspect2 value} => {:error, #{inspect2 reason}}" do
          assert @codec.encode(@value) === {:error, @reason}
        end
      end)
    end
  end
end
