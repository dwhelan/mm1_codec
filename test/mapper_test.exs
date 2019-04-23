defmodule MMS.MapperTest do
  use MMS.CodecTest
  import MMS.Mapper

  defp enhance(x), do: x + 1
  defp ok_enhance(x), do: ok x + 1
  defp err(_), do: error :details
  defp null(_), do: nil

  describe "decode_map with mapper of arity/1 should" do
    test "map ok values" do
      ok = ok 42, "rest"
      assert decode_map(ok, &enhance/1, __MODULE__) == ok(43, "rest")
      assert decode_map(ok, &ok_enhance/1, __MODULE__) == ok(43, "rest")
      assert decode_map(ok, &err/1, __MODULE__) == error(:mapper_test, 42, mapper: :details)
      assert decode_map(ok, &null/1, __MODULE__) == error(:mapper_test, 42, mapper: nil)
    end

    test "short circuit error results" do
      error = error :data_type, 42, :details
      assert decode_map(error, &enhance/1, __MODULE__) == error
      assert decode_map(error, &ok_enhance/1, __MODULE__) == error
      assert decode_map(error, &err/1, __MODULE__) == error
      assert decode_map(error, &null/1, __MODULE__) == error
    end
  end

  def enhance(x, rest), do: {x + 1, String.upcase(rest)}
  defp ok_enhance(x, rest), do: ok {x + 1, String.upcase(rest)}
  def err(_, _), do: error :details
  def null(_, _), do: nil

  describe "decode_map with mapper of arity/2 should" do
    test "map ok values" do
      ok = ok 42, "rest"
      assert decode_map(ok, &enhance/2, __MODULE__) == ok(43, "REST")
      assert decode_map(ok, &ok_enhance/2, __MODULE__) == ok(43, "REST")
      assert decode_map(ok, &err/2, __MODULE__) == error(:mapper_test, 42, mapper: :details)
      assert decode_map(ok, &null/2, __MODULE__) == error(:mapper_test, 42, mapper: nil)
    end

    test "short circuit error results" do
      error = error :data_type, 42, :details
      assert decode_map(error, &enhance/2, __MODULE__) == error
      assert decode_map(error, &ok_enhance/2, __MODULE__) == error
      assert decode_map(error, &err/2, __MODULE__) == error
      assert decode_map(error, &null/2, __MODULE__) == error
    end
  end

  defp diminish(x), do: x - 1
  defp ok_diminish(x), do: ok x - 1
  def diminish(x, rest), do: {x - 1, String.downcase(rest)}
  defp ok_diminish(x, rest), do: ok {x - 1, String.downcase(rest)}

  describe "encode_map with should" do
    test "map ok values" do
      ok = ok 42, "rest"
      assert encode_map(43, &diminish/1, __MODULE__) == ok(42)
      assert encode_map(43, &ok_diminish/1, __MODULE__) == ok(42)
      assert encode_map(43, &err/1, __MODULE__) == error(:mapper_test, 43, :details)
      assert encode_map(43, &null/1, __MODULE__) == error(:mapper_test, 43, nil)
    end

    test "short circuit error results" do
      error = error :data_type, 42, :details
      assert encode_map(error, &diminish/1, __MODULE__) == error
      assert decode_map(error, &err/1, __MODULE__) == error
      assert decode_map(error, &null/1, __MODULE__) == error
    end
  end


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
      assert CodecMap.decode_map(ok(2, "rest")) == error {:codec_map, 2, mapper: :not_found}
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
