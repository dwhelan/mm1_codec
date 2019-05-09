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

| Data type     | Detail Type                                        |
| ------------- | -------------------------------------------------- |
| primitive     | error atom                                         |
| or            | keyword list of data types and error atoms         |
| and           | keyword list - last item value will the error atom |
| delegation    | keyword list - last item value will the error atom |

## errors


# Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mm1_codec](https://hexdocs.pm/mm1_codec).

# To do
- consolidate length codecs
- create consistent `error` function for nesting
- refactoring
  - `decode {:ok, ...}` & `decode {:error, ...}` for codec composition
  - macro to decode/encode either 2 or a list of codecs
- `QuotedLength` enforces length > 30. Reconsider having different length representations
- create `decode_(...)` and`decode_as_one_of(...)`
- refactor `CodecMapper` to use core `Codec` functions
