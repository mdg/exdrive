defmodule Exdrive.Supervisor.Distributor do
    use Supervisor

    def start_link(cfg) do
        IO.puts("Distributor.start_link")
        Supervisor.start_link(__MODULE__, [])
    end

    def init(i) do
        IO.puts("Distributor.init")
        children = [
            worker(Exdrive.Worker, [:workfg])
        ]

        supervise(children, strategy: :one_for_one)
    end
end
