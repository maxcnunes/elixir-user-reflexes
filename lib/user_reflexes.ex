defmodule UserReflexes do
  @max_start_time 5
  @max_end_time 10

  def run do
    random_time = :random.uniform(@max_start_time) * 1000
    IO.puts("Press ENTER in #{random_time} milliseconds")

    current_time = Timex.Time.now(:msecs)
    go_time = current_time + random_time

    pid_timer = show_timer(go_time)
    pid_answer = wait_user_answer()

    receive do
      {:ok, answered_at}  ->
        current_time = Timex.Time.now(:msecs)
        cond do
          answered_at < go_time -> IO.puts("FAILED: Answred before the GO time")
          answered_at > go_time -> IO.puts("FAILED: Answred after the GO time")
          true -> IO.puts("SUCCESS: Perfect!")
        end
        IO.puts("Answred at #{current_time - go_time} milliseconds")

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
      send(caller, {:ok, Timex.Time.now(:msecs) })
    end)
  end

  defp show_timer(go_time) do
    current_time = Timex.Time.now(:msecs)
    remaining_time = go_time - current_time
    spawn(fn -> show_timer(go_time, remaining_time) end)
  end

  defp show_timer(_, remaining_time) when remaining_time <= 0 do
    IO.puts("GO!!!")
  end

  defp show_timer(go_time, remaining_time) do
    current_time = Timex.Time.now(:msecs)
    rt = go_time - current_time
    rt_secs = div(rt, 1_000)

    # only prints again if the second has changed
    if (rt_secs != div(remaining_time, 1_000)) do
      IO.puts("> #{rt_secs}")
    end

    show_timer(go_time, rt)
  end
end
