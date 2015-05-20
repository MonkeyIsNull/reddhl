defmodule Reddhl do
  def pull(subreddit) do
    HTTPoison.start
    out = HTTPoison.get! "http://www.reddit.com/r/" <> subreddit <> ".json"
    b = Poison.decode! out.body
    threads = b["data"]["children"]
  end

  def title(threads, num) do
    title(Enum.at(threads, num))
  end

  def title(thread) do
      thread["data"]["title"]
  end

  def url(threads, num) do
    url(Enum.at(threads, num))
  end

  def url(thread) do
    thread["data"]["url"]
  end

  
end
