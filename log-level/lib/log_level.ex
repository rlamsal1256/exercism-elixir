defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 && !legacy? -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 && !legacy?-> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    resp = to_label(level, legacy?)
    cond  do
      resp == :error or resp == :fatal -> :ops
      legacy? and resp == :unknown -> :dev1
      resp == :unknown -> :dev2
      true -> false
    end
  end
end
