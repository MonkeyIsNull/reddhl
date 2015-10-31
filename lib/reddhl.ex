defmodule Reddhl do

  @reddit_url Application.get_env(:reddhl, :reddit_url)

  @doc """
  Pull JSON of the 'hot' top 25 posts from a given subreddit.
  Then decodes the json.

      iex> Reddhl.pull("redditdev")
      %{...}
  """
  def pull(subreddit) do
    subreddit
    |> fetch
    |> handle_response
    |> decode_response
  end

  defp fetch(subreddit) do
    "#{@reddit_url}/r/#{subreddit}.json"
    |> HTTPoison.get
  end

  defp handle_response({:ok, %{status_code: 302, body: _, headers: _}}) do
    {:error, %{"error" => "Subreddit does not exist. Check spelling and try again."}}
  end

  defp handle_response({:ok, %{status_code: 200, body: body, headers: _}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  defp handle_response({:ok, %{status_code: _, body: body, headers: _}}) do
    {:error, Poison.Parser.parse!(body)}
  end

  defp decode_response({:ok, body}), do: body["data"]["children"]

  defp decode_response({:error, %{"error" => 403}}) do
      IO.puts "Error: You must be invited to visit this community"
      System.halt(2)
  end

  defp decode_response({:error, error}) do
    IO.puts "Error: #{error["error"]}"
    System.halt(2)
  end

  @doc """
  Returns the title of the thread at position 'num' in the threads Map.
  """
  def title(threads, num) do
    Enum.at(threads, num)
    |> _title
  end

  defp _title(thread) do
      thread["data"]["title"]
  end

  @doc """
  Returns the url of the thread at position 'num' in the threads Map.
  """
  def url(threads, num) do
    Enum.at(threads, num)
    |> _url
  end

  defp _url(thread) do
    thread["data"]["url"]
  end
end
