Reddhl
======

An headline and link puller for Reddit and its various subreddits

Given a subreddit it pulls the json data from Reddit which is usually the top 25 posts
You can then pull the title and url link for any of those.

# Usage
Here's how it works

```elixir
  threads = Reddhl.pull("elixir") # returns the top 25 "threads"
  Reddhl.url(threads, 1) # get the 1st post's url "https://medium.com/@mschae/measuring-your-phoenix-app-d63a77b13bda"
  Reddhl.title(threads, 1) # get the 1st post's title "Phoenix Monitor"
```

# Dep info

Add the dependency to your mix.exs file:

```elixir
  defp deps do
    [{:reddhl, "~> 0.0.2"}]
  end
```

## License Information

* reddhl: [LICENSE](LICENSE)

## Release Notes
### 0.0.2

Merged in code from jinyeow
Changed priv API from merge
 
### 0.0.1

Initial Release
