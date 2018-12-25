defmodule MMS.WellKnownParametersTestHelper do
  def parameter name, value do
    [{name, value}]
  end
end

defmodule MMS.WellKnownParametersTest do
  use ExUnit.Case
  import MMS.WellKnownParametersTestHelper
  alias MMS.WellKnownParameters

  time_zero = DateTime.from_unix!(0)

  use MMS.TestExamples,
      codec: WellKnownParameters,
      examples: [
        {<<128, 1>>,   parameter(MMS.Q,       "0.00")},
        {<<129, 128>>, parameter(MMS.Charset, :any  )},

        # Multiple headers
        {<<128, 1, 128, 1>>, [{MMS.Q, "0.00"}, {MMS.Q, "0.00"}]},
      ],

      encode_errors: [
        { [{MMS.NotAHeader, "x"}], {MMS.NotAHeader,  :invalid_well_known_parameter}},
      ]

  test "decode should terminate when an unmapped byte is found" do
#    assert Headers.decode(<<0x80>>) == {:ok, {[], <<0x80>>}}
  end
end
