defmodule MMS.QuotedLengthTest do
  use MMS.CodecTest

  import MMS.QuotedLength

  @length_quote 31

  @max max_uintvar_integer()
  @max_bytes max_uintvar_integer_bytes()

  @too_large @max + 1
  @too_large_bytes <<144, 128, 128, 128, 0>>

  codec_examples [
    {"min quoted length", <<@length_quote>> <> <<0>>,       0},
    {"max quoted length",  <<@length_quote>> <> @max_bytes, @max},
  ]

  decode_errors [
    {"missing length quote", <<0>>,                                    :does_not_start_with_a_length_quote},
    {"missing data bytes",   <<@length_quote>>,                       :insufficient_bytes},
    {"too large",            <<@length_quote>> <> @too_large_bytes, [:length, :uintvar_integer, {:out_of_range, @too_large}]},
  ]

  encode_errors [
    {"negative",  -1,          [:length, :uintvar_integer, :out_of_range]},
    {"too large", @too_large, [:length, :uintvar_integer, :out_of_range]},
  ]
end
