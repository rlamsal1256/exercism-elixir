defmodule LibraryFees do
  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  @spec before_noon?(NaiveDateTime.t()) :: boolean()
  def before_noon?(datetime), do: datetime.hour < 12

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      checkout_datetime |> NaiveDateTime.add(28, :day) |> NaiveDateTime.to_date()
    else
      checkout_datetime |> NaiveDateTime.add(29, :day) |> NaiveDateTime.to_date()
    end
  end

  @spec days_late(Date.t(), NaiveDateTime.t()) :: integer()
  def days_late(planned_return_date, actual_return_datetime) do
    [
      Date.diff(actual_return_datetime |> NaiveDateTime.to_date(), planned_return_date),
      0
    ] |> Enum.max
  end

  @spec monday?(NaiveDateTime.t()) :: boolean()
  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == 1
  end

  @spec calculate_late_fee(String.t(), String.t(), integer()) :: integer()
  def calculate_late_fee(checkout, return, rate) do
    checkout = datetime_from_string(checkout)
    return = datetime_from_string(return)

    late_fee = checkout |> return_date() |> days_late(return) |> Kernel.*(rate)
    if monday?(return), do: late_fee / 2 |> floor, else: late_fee
  end
end
