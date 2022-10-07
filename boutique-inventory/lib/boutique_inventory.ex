defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory |> Enum.sort_by(&(&1).price)
  end

  def with_missing_price(inventory) do
    inventory |> Enum.filter(&(&1).price |> is_nil)
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn i ->
      %{i | name: String.replace(i.name, old_word, new_word) }
    end)
  end

  def increase_quantity(item, count) do
    Map.update!(
      item,
      :quantity_by_size,
      fn q ->
        q |> Enum.into(%{}, fn ({k, v}) -> {k, v + count} end)
      end
    )
  end

  def total_quantity(item) do
    item.quantity_by_size
    |> Enum.reduce(0, fn ({_k, v}, acc) -> acc + v end)
  end
end
