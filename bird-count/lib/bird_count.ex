defmodule BirdCount do
  def today([]), do: nil
  def today([head | _]), do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([head | rest]), do: [head + 1 | rest]

  defp has_day_without_birds?(0, _), do: true
  defp has_day_without_birds?(_, []), do: false
  defp has_day_without_birds?(_, [head | rest]), do: has_day_without_birds?(head, rest)
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([head | rest]), do: has_day_without_birds?(head, rest)

  defp total(acc, []), do: acc
  defp total(acc, [head | rest]), do: total(acc + head, rest)
  def total([]), do: 0
  def total([head | rest]), do: total(head, rest)

  defp busy_days(acc, []), do: acc
  defp busy_days(acc, [head | rest ]) when head >= 5, do: busy_days(acc + 1, rest)
  defp busy_days(acc, [_ | rest ]), do: busy_days(acc, rest)
  def busy_days([]), do: 0
  def busy_days(list), do: busy_days(0, list)
end
