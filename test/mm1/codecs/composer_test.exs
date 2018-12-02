defmodule MM1.Codecs.ComposerTest do
  use ExUnit.Case

  alias WAP.ShortInteger

  import MM1.Codecs.Composer

  use MM1.Codecs.BaseExamples,
      examples: [
        {<<128, 129, 130>>, [0, 1, 2]}
      ],

      decode_errors: [
        {<<  1, 129, 130>>, :most_signficant_bit_must_be_1, [1]},
        {<<128,   1, 130>>, :most_signficant_bit_must_be_1, [0, 1]},
      ]

  def decode bytes do
    decode bytes, __MODULE__
  end

  def encode result do
    encode result, __MODULE__
  end

  def new values do
    new values, __MODULE__
  end

  def codecs do
   [ShortInteger, ShortInteger, ShortInteger]
  end
end
