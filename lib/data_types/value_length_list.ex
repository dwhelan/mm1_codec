defmodule MMS.Module do
  def create name, codec, arg do
    contents =
      quote do
        use MMS.Codec

        def decode bytes do
          bytes
          |> (unquote codec).decode(unquote arg)
        end

        def encode value do
          value
          |> (unquote codec).encode(unquote arg)
        end
      end

    Module.create name, contents, Macro.Env.location(__ENV__)
  end
end

defmodule MMS.ValueLengthList do
  use MMS.Codec
  import MMS.Module

  create(FooChild, MMS.List, [MMS.TextString, MMS.TextString])
  FooChild.__info__(:functions)
  |> IO.inspect()
  alias MMS.{List, ValueLength}

  IO.inspect(FooChild.decode <<"text\0text\0">>)

  def decode(bytes, codecs) when is_binary(bytes) and is_list(codecs) do
    bytes
    |> ValueLength.decode
    ~> fn {length, value_bytes} ->
         value_bytes
         |> List.decode(codecs)
         ~>> fn {data_type, _, details} -> error bytes, [data_type, Map.merge(details, %{length: length})] end
         ~> fn {values, rest} -> ensure_correct_length(length, value_bytes, values, rest, bytes) end
       end
  end

  defp ensure_correct_length(length, value_bytes, values, rest, _bytes) when length == byte_size(value_bytes) - byte_size(rest) do
    values |> ok(rest)
  end

  defp ensure_correct_length(length, value_bytes, values, rest, bytes) do
    bytes |> error(%{length: length, bytes_used: byte_size(value_bytes) - byte_size(rest), values: values})
  end

  def encode(values, codecs) when is_list(values) and is_list(codecs) do
    values
    |> List.encode(codecs)
    ~> fn value_bytes ->
         value_bytes
         |> byte_size
         |> ValueLength.encode
         ~> & &1 <> value_bytes
       end
  end
end
