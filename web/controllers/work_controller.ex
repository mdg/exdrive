defmodule Exdrive.WorkController do
  use Exdrive.Web, :controller

  def doit(conn, %{"job" => job}) do
    IO.puts("work/#{job}")
    text(conn, "work/#{job}\n")
  end
end
