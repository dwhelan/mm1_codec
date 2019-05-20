defmodule MMS.Module do
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
end
