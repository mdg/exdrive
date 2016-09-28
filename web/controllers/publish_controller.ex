defmodule Exdrive.PublishController do
  use Exdrive.Web, :controller

  def publish(conn, %{"job" => job}) do
    IO.puts("publish/#{job}")
    {:ok, pid} = ElixirTalk.connect('localhost', 11300)
    result = ElixirTalk.put(pid, job)
    text(conn, "publish/#{job} -> #{inspect(result)}\n")
  end
end

