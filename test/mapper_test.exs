defmodule MMS.MapperTest do
  use MMS.CodecTest
  import MMS.Mapper

  describe "functions with arity 1" do
    defmodule Plus1 do
      import MMS.Mapper

      defmapper fn x -> x + 1 end, fn x -> x - 1 end
    end

    test "decode_map" do
      assert Plus1.decode_map(ok(1, "rest")) == ok(2, "rest")
      assert Plus1.decode_map(error(:data_type, "bytes", :reason)) == error(:data_type, "bytes", :reason)
    end

    test "encode_map" do
      assert Plus1.encode_map(2) == ok(1)
    end
  end

  describe "functions with arity 2" do
    defmodule Plus1a do
      import MMS.Mapper

      defmapper fn x, _rest -> {x + 1, "rest!"} end, fn x -> x - 1 end
    end

    test "decode_map" do
      assert Plus1a.decode_map(ok(1, "rest")) == ok(2, "rest!")
      assert Plus1a.decode_map(error(:data_type, "bytes", :reason)) == error(:data_type, "bytes", :reason)
    end

    test "encode_map" do
      assert Plus1a.encode_map(2) == ok(1)
    end
  end

  describe "with captures" do
    defmodule Plus1Capture do
      import MMS.Mapper

      defmapper & &1 + 1, & &1 - 1
    end

    test "decode_map" do
      assert Plus1Capture.decode_map(ok(1, "rest")) == ok(2, "rest")
      assert Plus1Capture.decode_map(error(:data_type, "bytes", :reason)) == error(:data_type, "bytes", :reason)
    end

    test "encode_map" do
      assert Plus1Capture.encode_map(2) == ok(1)
    end
  end

  describe "with a map" do
    defmodule CodecMap do
      import MMS.Mapper

      defmapper %{0 => :a, 1 => :b}
    end

    test "decode_map" do
      assert CodecMap.decode_map(ok(0, "rest")) == ok(:a, "rest")
      assert CodecMap.decode_map(ok(1, "rest")) == ok(:b, "rest")
      assert CodecMap.decode_map(ok(2, "rest")) == error {:codec_map, 2, :not_found}
    end

    test "encode_map" do
      assert CodecMap.encode_map(:a) == ok(0)
      assert CodecMap.encode_map(:b) == ok(1)
      assert CodecMap.encode_map(:c) == error {:codec_map, :c, :not_found}
    end
  end

  test "enforce that map is a map" do
    assert_code_raise """
        defmodule ArugmentErrorTest do
          use MMS.CodecTest
          import MMS.Mapper

          defmapper "not a map"
        end
    """
  end

  test "enforce that mappers are functions" do
    assert_code_raise """
        defmodule ArugmentErrorTest do
          use MMS.CodecTest
          import MMS.Mapper

          defmapper "not a function", & &1
        end
    """
    assert_code_raise """
        defmodule ArugmentErrorTest do
          use MMS.CodecTest
          import MMS.Mapper

          defmapper & &1, "not a function"
        end
    """
  end
end
