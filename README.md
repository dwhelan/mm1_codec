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

# Codec functions

## decode(binary) -> Result
It must return a `%MM1.Result{}` with:
- `module` set to the codec moule, i.e.`__MODULE__`
- `bytes` set to the bytes consumed by the codec
- `rest` set to remaining bytes
- `bytes <> rest` must equal `binary`

If the input can be decoded:
- `value` set to the codec's understanding of the bytes consumed (non `nil`)
- `err` set to `nil`

If the input cannot be decoded:
- `value` set to `nil`
- `err` set to a list of error atoms

## encode(Result) -> binary

# Base decoder     
If you `use MM1.Base` in a module many of the responsibilites of the Codec functions will be provided:
- your module's `decode/1` function is guaranteed to be passed a non-zero length `binary`.

# Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mm1_codec](https://hexdocs.pm/mm1_codec).

