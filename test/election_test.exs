defmodule ElectionTest do
  use ExUnit.Case
  #doctest Election

  setup do
    %{election: %Election{}}
  end

  test "updating election name from command", ctx do
    command = "name Pop smoke"
    election = Election.update(ctx.election, command)
    assert election == %Election{name: "Pop smoke"}
  end

  test "adding a new candidate from a command", ctx do
    command = "add Toyosi Draycott"
    election = Election.update(ctx.election, command)
    assert election.candidates == [%Candidate{name: "Toyosi Draycott", id: 1}]
  end

  test "voting for a candidate from command", ctx do
    command2 = "vote 1"
    command = "add Toyosi Draycott"
    election = Election.update(ctx.election, command)
    |> Election.update(command2)
    assert election.candidates == [%Candidate{id: 1, votes: 1, name: "Toyosi Draycott"}]
  end

  test "quitting the app", ctx do
    command = "quit"
    election = Election.update(ctx.election, command)
    assert election == :quit
  end

  test "invaild command", ctx do
    command = "invalid"
    election = Election.update(ctx.election, command)
    assert election == ctx.election
  end


end
