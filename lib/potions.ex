defmodule Potions do
  use ExCLI.DSL, escript: true

  name "potions"
  description "find potions"
  long_description ~s"""
  Seriously there's an api
  full of fancy ones
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

  command :search do
    description "search for potions"
    long_description """
    Match all subsets of provided
    ingredients against all potions
    to find drinks you are capable of
    making.
    """

    run context do
      if context.verbose > 0 do
        IO.puts("searching for potions.....")
      end

      HTTPoison.start
      case HTTPoison.get("http://cocktails-api.herokuapp.com/ingredients") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          IO.puts "we printing ingredients bitch......................../\n"

          body
          |> Poison.decode!
          |> Enum.each(fn ing -> IO.inspect ing end)
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts "ingredients url not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
      end
      case  HTTPoison.get("http://cocktails-api.herokuapp.com/cocktails") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          IO.puts "we printing cocktails bitch........................./\n"

          body
          |> Poison.decode!
          |> Enum.each(fn %{"ingredient_ids" => ing_ids} -> IO.inspect ing_ids end)
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts "potions url not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
      end
    end
  end
end
