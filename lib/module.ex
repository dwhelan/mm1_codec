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
