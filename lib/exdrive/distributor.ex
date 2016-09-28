defmodule Exdrive.Distributor do
    use Application

    def start(_type) do
        GenServer.start_link(__MODULE__, :ok, [])
    end

    def init(:ok) do
        {:ok, %{}}
    end

end
