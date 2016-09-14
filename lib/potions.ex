defmodule Potions do
  use ExCLI.DSL, escript: true

  import Potions.API


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

      get "ingredients"
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

      get "cocktails"
    end
  end
end
