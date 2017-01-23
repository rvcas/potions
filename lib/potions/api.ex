defmodule Potions.API do
  def get(query) do
    case HTTPoison.get("http://cocktails-api.herokuapp.com/#{query}") do
      { :ok, %HTTPoison.Response{ status_code: 200, body: body } } ->
        { :ok, Poison.decode!(body) }
      { :error, %HTTPoison.Error{ reason: reason } } ->
        { :error, reason }
    end
  end
end
