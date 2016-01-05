defmodule UserReflexes do
  @max_start_time 5
  @max_end_time 10

  def run do
    random_time = :random.uniform(@max_start_time)
    IO.puts("Press ENTER in #{random_time} seconds")

    current_time = Timex.Time.now(:secs)
    go_time = current_time + random_time

    pid_timer = show_timer(go_time)
    pid_answer = wait_user_answer()

    receive do
      {:ok, answered_at}  ->
        current_time = Timex.Time.now(:secs)
        cond do
          answered_at < go_time -> IO.puts("FAILED: Answred before the GO time")
          answered_at > go_time -> IO.puts("FAILED: Answred after the GO time")
          true -> IO.puts("SUCCESS: Perfect!")
        end
        IO.puts("Answred at #{current_time - go_time} secs")

        # leave children process
        Process.exit(pid_answer, :exit)
        Process.exit(pid_timer, :exit)
    after
      @max_end_time * 1000 -> IO.puts("Finished without answer")
    end
  end

  defp wait_user_answer do
    caller = self()
    spawn(fn ->
      IO.gets("")
      send(caller, {:ok, Timex.Time.now(:secs) })
    end)
  end

  defp show_timer(go_time) do
    current_time = Timex.Time.now(:secs)
    remaining_time = go_time - current_time
    spawn(fn -> show_timer(go_time, remaining_time) end)
  end

  defp show_timer(go_time, remaining_time) do
    current_time = Timex.Time.now(:secs)
    cond do
      current_time >= go_time -> IO.puts("GO!!!")
      true ->
        rt = go_time - current_time
        # only prints again if the second has changed
        if (rt != remaining_time) do
          IO.puts("> #{rt}")
        end
        show_timer(go_time, rt)
    end
  end
end
