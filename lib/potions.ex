defmodule Potions do
  use ExCLI.DSL, escript: true

  name "sips"
  description "find cocktails"
  long_description ~s"""
  Seriously there's an api
  """

  option :verbose, count: true, aliases: [:v]

  command :ingredients do
    description "Gets Ingredients"
    long_description """
    Prints out a list of all Ingredients
    """

    run context do
      if context.verbose > 0 do
        IO.puts("fetching ingredients.....")
      end

      HTTPoison.start
      case HTTPoison.get("http://cocktails-api.herokuapp.com/ingredients") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          body
          |> Poison.decode!
          |> Enum.each(fn %{"name" => name} -> IO.puts name end)
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts "Not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
      end
    end
  end
end
