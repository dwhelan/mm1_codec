defmodule MM1.Codecs2.TestExamples do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec          opts[:codec]         || __MODULE__
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      encode_errors = opts[:encode_errors] || []

      Enum.each(examples, fn {bytes, value} ->
        @bytes bytes
        @value value

        test "decode #{inspect bytes} === {:ok, {#{inspect value}, 'rest'}}" do
          if is_tuple(@value) do
            {value, rest} = @value
            assert @codec.decode(@bytes <> "rest") === {:ok, {value, rest <> "rest"}}
          else
            assert @codec.decode(@bytes <> "rest") === {:ok, {@value, "rest"} }
          end
        end

        test "encode #{inspect value} === {:ok, #{inspect bytes}}" do
          if is_tuple(@value) do
            {value, rest} = @value
            assert @codec.encode(value) === {:ok, @bytes}
          else
            assert @codec.encode(@value) === {:ok, @bytes}
          end
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
