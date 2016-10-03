defmodule Exdrive.StatsController do
  use Exdrive.Web, :controller

  def stats(conn, _) do
    IO.puts("stats")
    queue_info = :ets.info(:queue_table)
    work_info = :ets.info(:work_table)
    queued = Enum.into(List.first(:ets.match(:queue_table, :'$1')), %{})
    working = Enum.into(List.first(:ets.match(:work_table, :'$1')), %{})
    info = %{:queue_sizes => queued,
        :work_sizes => working}
        #{:queue_info, queue_info},
        #{:work_info, work_info}]
    result = Poison.encode!(info)
    text(conn, "#{result}\n")
  end
end


