defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({atom, _, func} = ast, acc) when atom in [:def, :defp] do
    {f_name, arity} = func_name_and_arity(func)

    len = if is_nil(arity), do: 0, else: arity |> length()
    name = f_name |> to_string() |> String.split_at(len) |> elem(0)
    {ast, [name | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp func_name_and_arity([{:when, _, [{f_name, _, arity}, _]}, _]), do: {f_name, arity}
  defp func_name_and_arity([{f_name, _, arity}, _]), do: {f_name, arity}

  def decode_secret_message(string) do
    ast = string |> to_ast()
    {_, acc} = Macro.prewalk(ast, [], fn (asts, acc) -> decode_secret_message_part(asts, acc) end)
    acc |> Enum.reverse() |> Enum.join()
  end
end
