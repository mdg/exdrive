defmodule Exdrive.Distributor do
    use GenServer

    def start_link(cfg) do
        GenServer.start_link(__MODULE__, cfg)
    end

    def init(_cfg) do
        import Supervisor.Spec

        IO.puts("Distributor.init")
        children = [
            worker(Exdrive.Pipe, [:high], id: 1),
            worker(Exdrive.Pipe, [:default], id: 2),
            worker(Exdrive.Pipe, [:low], id: 3),
        ]

        IO.puts("Workers: #{inspect children}")
        opts = [strategy: :one_for_one, name: Exdrive.Distributor.Supervisor]
        {:ok, ch} = Supervisor.start_link(children, opts)
        IO.puts("Supervised Workers: #{inspect ch}")
        chlist = Supervisor.which_children(ch)
        IO.puts("which_children: #{inspect chlist}")
        {:ok, ch}
    end

    def handle_cast(:reload, _newcfg) do
        # close all the old children and restart new ones w/ new config
    end
    def handle_cast(:quit, _) do
    end
end
