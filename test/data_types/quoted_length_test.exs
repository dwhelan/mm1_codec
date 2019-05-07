defmodule MMS.QuotedLengthTest do
  use MMS.CodecTest

  import MMS.QuotedLength

  @min 31
  @min_bytes <<@min>>

  @max max_uintvar_integer()
  @max_bytes max_uintvar_integer_bytes()

  codec_examples [
    {"min value", <<length_quote()>> <> @min_bytes, @min},
    {"max value", <<length_quote()>> <> @max_bytes, @max},
  ]

  @too_small @min - 1
  @too_small_bytes <<@too_small>>

  @too_large @max + 1
  @too_large_bytes <<144, 128, 128, 128, 0>>

  decode_errors [
    {"missing length quote", <<0>>,                                 :does_not_start_with_a_length_quote},
    {"missing data bytes",   <<length_quote()>>,                     [:length, :no_bytes]},
    {"too small",            <<length_quote()>> <> @too_small_bytes, out_of_range: @too_small},
    {"too large",            <<length_quote()>> <> @too_large_bytes, [:length, :uintvar_integer, {:out_of_range, @too_large}]},
  ]

  encode_errors [
    {"negative",  -1,         :out_of_range},
    {"too small", @too_small, :out_of_range},
    {"too large", @too_large, :out_of_range},
  ]
end
