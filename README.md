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
