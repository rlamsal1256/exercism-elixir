defmodule TakeANumber do
  def start do
    spawn(fn -> loop(0) end)
  end

  defp loop(acc) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, acc)
        loop(acc)

      {:take_a_number, sender_pid} ->
        acc = acc + 1
        send(sender_pid, acc)
        loop(acc)

      :stop -> IO.puts "stop"

      _ -> loop(acc)
    end
  end
end
