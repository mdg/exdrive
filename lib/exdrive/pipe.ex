defmodule Exdrive.Pipe do
    use GenServer

    def start_link(prio) do
        IO.puts("Pipe.start_link(#{prio})")
        {:ok, bspid} = ElixirTalk.connect('localhost', 11300)
        if prio != "default" do
            ElixirTalk.ignore(bspid, "default")
            ElixirTalk.watch(bspid, prio)
        end
        l = GenServer.start_link(__MODULE__, bspid)
        IO.puts("Pipe.start_link() = #{inspect l}")
        l
    end

    def init(pid) do
        IO.puts("Pipe.init()")
        GenServer.cast(self(), :work)
        {:ok, pid}
    end

    def handle_cast(:work, pid) do
        dowork(pid)
        GenServer.cast(self(), :work)
        {:noreply, pid}
    end
    def handle_cast(:quit, state) do
        {:noreply, state}
    end

    def terminate(_reason, pid) do
        ElixirTalk.quit(pid)
    end

    def dowork(pid) do
        {:reserved, job_id, job_data} = ElixirTalk.reserve(pid)
        IO.puts("job_id: #{job_id}, job_input: #{job_data}")
        new_count = :ets.update_counter(:work_table, job_data, 1,
            {job_data, 0})
        path = "http://localhost:4000/queue/work/#{job_data}"
        IO.puts("send POST -> #{path}")
        result = HTTPotion.post(path)
        IO.puts(inspect result)
        :ets.update_counter(:work_table, job_data, -1,
            {job_data, 0})
        ElixirTalk.delete(pid, job_id)
        new_count = :ets.update_counter(:queue_table, job_data, -1,
            {job_data, 0})
        IO.puts("new_count #{new_count}")
        dowork(pid)
    end
end

