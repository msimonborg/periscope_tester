defmodule PeriscopeTesterTest do
  use ExUnit.Case
  doctest PeriscopeTester

  test "greets the world" do
    assert PeriscopeTester.hello() == :world
  end
end
