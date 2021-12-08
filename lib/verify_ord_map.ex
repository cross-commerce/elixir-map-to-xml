defmodule VerifyOrdMap do
  @error_message "when using a OrdMap, all maps must be a OrdMap too"

  def verify(%OrdMap{} = map) do
    if deep_is_ord_map(map) do
      map
    else
      raise @error_message
    end
  end

  def verify(%{} = map) do
    if deep_has_ord_map?(map) do
      raise @error_message
    else
      map
    end
  end

  defp deep_is_ord_map(%OrdMap{} = map) do
    map
    |> Enum.map(fn {_key, value} -> !is_map(value) || is_ord_map(value) end)
    |> Enum.all?()
  end

  defp deep_is_ord_map(%{}), do: false

  defp is_ord_map(list) when is_list(list), do: Enum.map(list, &deep_is_ord_map/1)
  defp is_ord_map(%OrdMap{} = map), do: deep_is_ord_map(map)
  defp is_ord_map(%{}), do: false
  defp is_ord_map(_), do: false

  defp deep_has_ord_map?(map) do
    map
    |> Enum.map(fn {_key, value} -> is_ord_map(value) end)
    |> Enum.any?()
  end
end
