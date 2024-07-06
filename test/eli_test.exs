defmodule EliTest do
  use ExUnit.Case
  doctest Eli

  test "greets the world" do
    assert Eli.hello() == :world
  end
end
