defmodule Username do
  @doc """
  ä becomes ae
  ö becomes oe
  ü becomes ue
  ß becomes ss
  """
  def sanitize([]), do: ''
  def sanitize([head | tail]) do
    ans = case head do
      head when ?a <= head  and head <= ?z -> [head]
      ?_ -> '_'
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> ''
    end
    ans ++ sanitize(tail)
  end
end
