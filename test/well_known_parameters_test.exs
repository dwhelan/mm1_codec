defmodule MMS.WellKnownParametersTestHelper do
  def parameter name, value do
    [{name, value}]
  end
end

defmodule MMS.WellKnownParametersTest do
  use ExUnit.Case
  import MMS.WellKnownParametersTestHelper
  alias MMS.WellKnownParameters

  use MMS.TestExamples,
      codec: WellKnownParameters,
      examples: [
        {<<128, 1>>,   parameter(:q,       "0.00")},
        {<<129, 128>>, parameter(:charset, :any  )},

        # Multiple headers
        {<<128, 1, 128, 1>>, [{:q, "0.00"}, {:q, "0.00"}]},
      ],

      encode_errors: [
#        { [{MMS.NotAHeader, "x"}], {MMS.NotAHeader,  :invalid_well_known_parameter}},
      ]

  test "decode should terminate when an unmapped byte is found" do
#    assert Headers.decode(<<0x80>>) == {:ok, {[], <<0x80>>}}
  end
end
