defmodule Exdrive.Worker do
    use Supervisor

    def start_link(cfg) do
        IO.puts("Worker.start_link")
        GenServer.start_link(__MODULE__, [])
    end

    def init(cfg) do
        IO.puts("Worker.init")
        run(cfg)
        {:ok, :something}
    end

    def run(cfg) do
        IO.puts("Worker.run")
        run(cfg)
    end

end
