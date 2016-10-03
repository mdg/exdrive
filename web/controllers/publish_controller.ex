defmodule Exdrive.PublishController do
  use Exdrive.Web, :controller

  def is_valid_prio("high"), do: true
  def is_valid_prio("default"), do: true
  def is_valid_prio("low"), do: true
  def is_valid_prio(_), do: false

  def publish(conn, %{"prio" => prio, "job" => job}) do
    IO.puts("publish/#{prio}/#{job}")
    if !is_valid_prio(prio) do
        text(conn, "invalid priority: #{prio}\n")
    else
        {:ok, pid} = ElixirTalk.connect('localhost', 11300)
        ElixirTalk.use(pid, prio)
        result = ElixirTalk.put(pid, job)
        :ets.update_counter(:queue_table, job, 1, {job, 0})
        text(conn, "publish/#{job} -> #{inspect(result)}\n")
    end
  end
end

