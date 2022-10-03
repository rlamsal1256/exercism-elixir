defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    tl(list)
  end

  def first(list) do
    hd(list)
  end

  def count(list) do
    count(0, list)
  end

  defp count(acc, []), do: acc
  defp count(acc, [_head | tail]), do: count(acc + 1, tail)

  def functional_list?(list) do
    functional_list?("Elixir", list)
  end

  defp functional_list?(_, []), do: false
  defp functional_list?(term, [head | tail]) do
    if head == term do
      true
    else
      functional_list?(term, tail)
    end
  end
end
