defmodule MMS.QuotedLengthTest do
  use MMS.CodecTest
  alias MMS.CodecTest.{Ok, Error}

  import MMS.QuotedLength

  def min_uint32_length,       do: max_short_length() + 1
  def min_uint32_length_value, do: String.duplicate("a", min_uint32_length())
  def min_uint32_length_bytes, do: <<min_uint32_length()>> <> min_uint32_length_value()

  @min_uint32_length max_short_length() + 1
  @min_uint32_length_value String.duplicate("a", @min_uint32_length)
  @min_uint32_length_bytes <<@min_uint32_length>>

  @length_quote 31
  @min_value max_short_length() + 1
  @max_value max_unitvar_integer()

  codec_examples [
    {"smallest quoted length", <<@length_quote, 0>>, 0},
    {"largest quoted length",  <<@length_quote>> <> max_unitvar_integer_bytes, max_unitvar_integer()},
  ]

  decode_errors [
    {"missing length quote", <<0>>,                                    :does_not_start_with_a_length_quote},
    {"missing data bytes",   <<@length_quote>>,                       :insufficient_bytes},
    {"too large",            <<@length_quote, 144, 128, 128, 128, 0>>, [:length, :uintvar_integer, {:out_of_range, max_unitvar_integer() + 1}]},
  ]

  encode_errors [
    {"too small", -1,             [:length, :uintvar_integer, :out_of_range]},
    {"too large", @max_value + 1, [:length, :uintvar_integer, :out_of_range]},
  ]
end
