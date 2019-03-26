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
`decode(input)` must return a `%MMS.Result{}` with:
- `module` set to the module of the codec, i.e.`__MODULE__`
- `bytes` set to the bytes consumed by the codec
- `rest` set to remaining bytes
- `bytes <> rest` equal to `input`

If the input can be decoded:
- `value` set to the codec's understanding of the bytes consumed (non `nil`)
- `err` set to `nil`

If the input cannot be decoded:
- `value` set to `nil`
- `err` set to a list of error atoms:
    - `:must_be_a_binary` if `input` is not a `binary`
    - `:insufficient_bytes` if `input == <<>>`
    - or an error specific to the codec

## encode(Result) -> binary

# Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mm1_codec](https://hexdocs.pm/mm1_codec).

# To do
- create decode_as_one_of(...)
- refactor CodecMapper to use core decode functions
- consolidate CoderError into Codec
