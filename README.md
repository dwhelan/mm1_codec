# Mm1Codec

**TODO: Add description**

## Installation
If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mm1_codec` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mm1_codec, "~> 0.1.0"}
  ]
end
```

# Specifications

# Codec functions

## decode
## encode

# Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mm1_codec](https://hexdocs.pm/mm1_codec).

# To do
- consider test macro s
```elixir
defmacro test_codec_ok desc, bytes, value do
end

defmacro test_decode_error desc, bytes, error do
end

defmacro test_encode_error desc, value, error do
end

````

- consider decode {:ok, ...} & decode {:error, ...} for codec composition
- consider having decode_as(...) etc, take a `__MODULE__` parameter
- consider macro to decode/encode either 2 or a list of codecs
- create decode_as_one_of(...)
- refactor CodecMapper to use core decode functions
- consolidate CoderError into Codec
