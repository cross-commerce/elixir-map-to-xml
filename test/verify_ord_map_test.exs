defmodule VerifyOrdMapTest do
  use ExUnit.Case

  import OrdMap

  describe "verify/1" do
    test "returns the given map if it's not a OrdMap" do
      map = %{key: :value}

      assert VerifyOrdMap.verify(map) == map
    end

    test "returns the given map if all maps are a OrdMap" do
      map =
        o(%{
          key1: o(%{key2: :value})
        })

      assert VerifyOrdMap.verify(map) == map
    end

    test "raise if the given map has normal maps and OrdMaps" do
      assert_raise RuntimeError,
                   "when using a OrdMap, all maps must be a OrdMap too",
                   fn ->
                     VerifyOrdMap.verify(
                       o(%{
                         key1: %{key2: :value}
                       })
                     )
                   end

      assert_raise RuntimeError,
                   "when using a OrdMap, all maps must be a OrdMap too",
                   fn ->
                     MapToXml.from_map(%{
                       "Tag1" =>
                         o(%{
                           "Tag2" => "Value1"
                         })
                     })
                   end
    end
  end
end
