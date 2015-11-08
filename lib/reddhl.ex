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

  # Everything is ok
  defp handle_response({:ok, %{status_code: 200, body: body, headers: _}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  # We choked on something not a 200
  defp handle_response({:ok, %{status_code: 302, body: _, headers: _}}) do
    {:error, "Subreddit does not exist. Check spelling and try again."}
  end

  defp handle_response({:ok, %{status_code: _, body: body, headers: _}}) do
    {:error, Poison.Parser.parse!(body)}
  end

  # Decoding the responses
  defp decode_response({:ok, body}), do: body["data"]["children"]

  defp decode_response({:error, %{"error" => 403}}) do
    {:error, "You must be invited to visit this community"}
  end

  defp decode_response({:error, error}) do
    {:error, error}
  end

  #Public API
  @doc """
  Returns the title of the thread at position 'num' in the threads Map.
  """
  def title(threads, num) do
    Enum.at(threads, num)
    |> get_title
  end


  @doc """
  Returns the url of the thread at position 'num' in the threads Map.
  """
  def url(threads, num) do
    Enum.at(threads, num)
    |> get_url
  end

  # Utility Funcs
  defp get_title(thread) do
      thread["data"]["title"]
  end

  defp get_url(thread) do
    thread["data"]["url"]
  end
end
