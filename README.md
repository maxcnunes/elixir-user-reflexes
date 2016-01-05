# user-reflexes

This week I was reading [Go weekly](http://golangweekly.com/issues/90) and there was a post [Go Concurrency versus C and pthreads](http://denis.papathanasiou.org/posts/2015.12.26.post.html) with the following programming challenge:

> Write a program to test user reflexes: when it runs, it waits a random amount of time between 1 and 10 seconds, and prints "GO!" as a prompt.

> It then expects the user to hit the enter key, and times how fast enter is pressed, in milliseconds.

> If the enter key is pressed before the "GO!" prompt appears, the program prints "FAIL".

In that post it was implemented in Go and C. Since I'm learning Elixir I decided to implement it as well.

## Running

```bash
mix deps.get
iex -S mix run
UserReflexes.run
```

**Example**

```bash
➜  user_reflexes master ✓ iex -S mix run
Erlang/OTP 18 [erts-7.1] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

ExSync started.
Interactive Elixir (1.1.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> UserReflexes.run
Press ENTER in 3000 milliseconds
> 2
> 1
> 0

FAILED: Answred before the GO time
Answred at -162 milliseconds
true
iex(2)>
```
