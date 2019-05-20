defmodule MMS.Module do
  defmacro create codecs do
    quote do
     IO.inspect  module_name = name(unquote(__CALLER__.module), unquote(codecs))
      create module_name, unquote(codecs)
    end
  end

  def create(name, codecs) when is_atom(name) and is_list(codecs) do
    create name, MMS.List, codecs
  end

  def create(name, codecs) when is_atom(name) and is_tuple(codecs) do
    create name, MMS.Tuple, Macro.escape(codecs)
  end

  def create(name, codec, arg) when is_atom(name) and is_atom(codec) do
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

  def name(module, codecs) when is_atom(module) and is_tuple(codecs) do
    name module, Tuple.to_list(codecs)
  end

  def name(module, []) when is_atom(module) do
    name module, [Empty]
  end

  def name(module, codecs) when is_atom(module) and is_list(codecs) do
    codec_names =
      codecs
      |> Enum.map(
           fn codec ->
             codec
             |> to_string
             |> String.split(".")
             |> List.last
           end
         )
      |> Enum.join()

    "#{module}.#{codec_names}"
    |> String.to_atom
  end
end
