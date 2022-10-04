defmodule NameBadge do
  def print(nil, name, nil), do: "#{name} - OWNER"
  def print(id, name, nil), do: "[#{id}] - #{name} - OWNER"
  def print(id, name, department) do
    if is_nil(id) do
      "#{name} - #{department |> String.upcase}"
    else
      "[#{id}] - #{name} - #{department |> String.upcase}"
    end
  end
end
