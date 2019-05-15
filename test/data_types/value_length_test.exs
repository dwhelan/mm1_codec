defmodule MMS.ValueLengthTest do
  use MMS.CodecTest
  import MMS.ValueLength

  @thirty_chars String.duplicate("a", 30)

  codec_examples [
    {"min short length", {<<0>>, <<>>}, 0},
    {"max short length", {<<30>>, @thirty_chars}, 30},
    {"min quoted length", <<length_quote(), min_quoted_length()>>, min_quoted_length()},
    {"max quoted length", <<length_quote()>> <> max_uintvar_integer_bytes(), max_uintvar_integer()},
  ]

  decode_errors [
    {"length error", <<5, "rest">>, [short_length: [required_bytes: 5, available_bytes: 4], quoted_length: :does_not_start_with_a_length_quote]},
  ]

  encode_errors [
    {"length error", "a", short_length: :out_of_range, quoted_length: :out_of_range},
  ]
end
