defmodule Exdrive.Distributor do
    use GenServer

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

    def startwork() do
        {:ok, pid} = ElixirTalk.connect('localhost', 11300)
        IO.puts("doing work")
        dowork(pid)
    end

    def dowork(pid) do
        {:reserved, job_id, job_data} = ElixirTalk.reserve(pid)
        IO.puts("job_id: #{job_id}, job_input: #{job_data}")
        path = "http://localhost:4000/api/work/#{job_data}"
        IO.puts("send POST -> #{path}")
        result = HTTPotion.post(path)
        IO.puts(inspect result)
        ElixirTalk.delete(pid, job_id)
        dowork(pid)
    end

end
