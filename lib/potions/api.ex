defmodule Potions.API do
  def get(query) do
    HTTPoison.start
    case HTTPoison.get("http://cocktails-api.herokuapp.com/#{query}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!
        |> IO.inspect
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
end
