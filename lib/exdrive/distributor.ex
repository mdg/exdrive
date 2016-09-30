defmodule Exdrive.Distributor do
    use Supervisor
    # import Supervisor.Spec

    def start_link(cfg) do
        Supervisor.start_link(__MODULE__, cfg)
    end

    def init(_cfg) do
        IO.puts("Distributor.init")
        children = [
            worker(Exdrive.Pipe, [:high], id: 1),
            worker(Exdrive.Pipe, [:default], id: 2),
            worker(Exdrive.Pipe, [:low], id: 3),
        ]

        IO.puts("Workers: #{inspect children}")
        ch = supervise(children, strategy: :one_for_one)
        IO.puts("Supervised Workers: #{inspect ch}")
        ch
    end

    def handle_cast(:reload, _newcfg) do
        # close all the old children and restart new ones w/ new config
    end
    def handle_cast(:quit, _) do
    end
end
