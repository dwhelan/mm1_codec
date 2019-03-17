defmodule MMS.TokenTextTest do
  use MMS.CodecTest

  use MMS.TestExamples,
      codec: MMS.TokenText,

      examples: [
        {<<"string", 0>>, "string"},
      ],

      decode_errors: [
        {<<0>>,        {:token_text, <<0>>,    :must_have_at_least_one_character}    },
        {<<1, 0>>,     {:token_text, <<1, 0>>, :first_byte_must_be_a_zero_or_a_char} },
        {<<"string">>, {:token_text, "string", :missing_end_of_string}               },
      ],

      encode_errors: [
        {"",       {:token_text, "",       :must_have_at_least_one_character}    },
        {"x\0",    {:token_text, "x\0",    :contains_end_of_string}              },
        {<<1, 0>>, {:token_text, <<1, 0>>, :first_byte_must_be_a_zero_or_a_char} },
      ]

  describe "is_control: ensure" do
    test "0 is a control"       do assert is_control(0) end
    test "31 is a control"      do assert is_control(31) end
    test "32 is not a control"  do refute is_control(32) end
    test "126 is not a control" do refute is_control(126) end
    test "127 is a control"     do assert is_control(127) end
    test "128 is not a control" do refute is_control(128) end
    test "255 is not a control" do refute is_control(255) end
  end

  describe "is_separator: ensure" do
    test "'(' is a separator" do assert is_separator(?() end
    test "')' is a separator" do assert is_separator(?)) end
    test "'<' is a separator" do assert is_separator(?<) end
    test "'>' is a separator" do assert is_separator(?>) end
    test "'@' is a separator" do assert is_separator(?@) end
    test "',' is a separator" do assert is_separator(?,) end
    test "';' is a separator" do assert is_separator(?;) end
    test "':' is a separator" do assert is_separator(?:) end
    test "'\\' is a separator" do assert is_separator(?\\) end
    test "'\"' is a separator" do assert is_separator(?\") end
    test "'/' is a separator" do assert is_separator(?/) end
    test "'[' is a separator" do assert is_separator(?[) end
    test "']' is a separator" do assert is_separator(?]) end
    test "'?' is a separator" do assert is_separator(??) end
    test "'=' is a separator" do assert is_separator(?=) end
    test "'{' is a separator" do assert is_separator(?{) end
    test "'}' is a separator" do assert is_separator(?}) end
    test "'space' is a separator" do assert is_separator(?\s) end
    test "'tab' is a separator" do assert is_separator(?\t) end
  end

  describe "is_token: ensure" do
    test "0 is not a token" do assert is_token(0) == false end
    test "32 is not a token" do assert is_token(32) == false end

    test "33 is a token" do assert is_token(33)   == true end
    test "127 is not a token" do refute is_token(127) end

    test "128 is not a token" do assert is_token(128) == false end
    test "255 is not a token" do assert is_token(255) == false end

    test "'(' is not a token" do assert is_token(?() == false end
    test "')' is not a token" do assert is_token(?)) == false end
    test "'<' is not a token" do assert is_token(?<) == false end
    test "'>' is not a token" do assert is_token(?>) == false end
    test "'@' is not a token" do assert is_token(?@) == false end
    test "',' is not a token" do assert is_token(?,) == false end
    test "';' is not a token" do assert is_token(?;) == false end
    test "':' is not a token" do assert is_token(?:) == false end
    test "'\\' is not a token" do assert is_token(?\\) == false end
    test "'\"' is not a token" do assert is_token(?\") == false end
    test "'/' is not a token" do assert is_token(?/) == false end
    test "'[' is not a token" do assert is_token(?[) == false end
    test "']' is not a token" do assert is_token(?]) == false end
    test "'?' is not a token" do assert is_token(??) == false end
    test "'=' is not a token" do assert is_token(?=) == false end
    test "'{' is not a token" do assert is_token(?{) == false end
    test "'}' is not a token" do assert is_token(?}) == false end
    test "' ' is not a token" do assert is_token(?\s) == false end
    test "'\t' is not a token" do assert is_token(?\t) == false end
  end
end
