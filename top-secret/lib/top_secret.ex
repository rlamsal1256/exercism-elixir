defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({atom, _, func} = ast, acc) when atom in [:def, :defp] do
    {f_name, arity} = func_name_and_arity(func)
    {ast, [f_name |> to_string() |> String.split_at(arity) |> elem(0) | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp func_name_and_arity([{:when, _, [{f_name, _, arity}, _]}, _]), do: {f_name, length(arity)}
  defp func_name_and_arity([{f_name, _, nil}, _]), do: {f_name, 0}
  defp func_name_and_arity([{f_name, _, arity}, _]), do: {f_name, length(arity)}

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &(decode_secret_message_part(&1, &2)))
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end
