defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path = path |> String.split(".")
    do_extract_from_path(data, path)
  end

  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(data, [h|t]), do: do_extract_from_path(data[h], t)

  def get_in_path(data, path) do
    data |> Kernel.get_in(path |> String.split("."))
  end
end
