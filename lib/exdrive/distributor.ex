defmodule Exdrive.Distributor do
    use Application

    def start(_type, _args) do
        import Supervisor.Spec, warn: false

        children = [
            # Start the endpoint when the application starts
            supervisor(Exdrive.Distributor.Server, []),
            # Here you could define other workers and supervisors as children
            # worker(Exdrive.Worker, [arg1, arg2, arg3]),
        ]

        # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
        # for other strategies and supported options
        opts = [strategy: :one_for_one, name: Exdrive.Supervisor]
        Supervisor.start_link(children, opts)
        Exdrive.Distributor.Supervisor.start_link()
        Supervisor.start_link(children, opts)
    end

end
