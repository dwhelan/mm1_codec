defmodule MM1.Codecs2.TestExamples do
  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @codec          opts[:codec]
      examples      = opts[:examples]      || []
      decode_errors = opts[:decode_errors] || []
      encode_errors = opts[:encode_errors] || []

      Enum.each(examples, fn {bytes, value} ->
        @bytes bytes
        @value value

        test "decode(#{inspect bytes}) === {:ok, {{inspect value}}}" do
          assert @codec.decode(@bytes <> "rest") === {:ok, {@value, @codec, "rest"}}
        end

        test "encode(#{inspect value}) === {:ok, #{inspect bytes}}" do
          assert @codec.encode(@value) === {:ok, {@bytes, @codec}}
        end
      end)

      Enum.each(decode_errors, fn {bytes, error} ->
        @bytes bytes
        @error error

        test "decode(#{inspect @bytes}) => {:error, {{inspect @error}}}" do
          assert @codec.decode(@bytes) === {:error, {@error, @codec}}
        end
      end)

      Enum.each(encode_errors, fn {value, error} ->
        @value value
        @error error

        test "encode(#{inspect @value}) => {:error, #{inspect @error}}" do
          assert @codec.encode(@value) === {:error, {@error, @codec}}
        end
      end)
    end
  end
end
