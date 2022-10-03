defmodule KitchenCalculator do
  def get_volume({_, vol}), do: vol

  def to_milliliter({:milliliter, vol}), do: {:milliliter, vol}
  def to_milliliter({:cup, vol}), do: {:milliliter, vol * 240}
  def to_milliliter({:fluid_ounce, vol}), do: {:milliliter, vol * 30}
  def to_milliliter({:teaspoon, vol}), do: {:milliliter, vol * 5}
  def to_milliliter({:tablespoon, vol}), do: {:milliliter, vol * 15}

  def from_milliliter({:milliliter, vol}, :milliliter), do: {:milliliter, vol}
  def from_milliliter({:milliliter, vol}, :cup), do: {:cup, vol / 240}
  def from_milliliter({:milliliter, vol}, :fluid_ounce), do: {:fluid_ounce, vol / 30}
  def from_milliliter({:milliliter, vol}, :teaspoon), do: {:teaspoon, vol / 5}
  def from_milliliter({:milliliter, vol}, :tablespoon), do: {:tablespoon, vol / 15}

  def convert(volume_pair, unit), do: from_milliliter(to_milliliter(volume_pair), unit)
end
