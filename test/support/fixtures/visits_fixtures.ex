defmodule Emr.VisitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Emr.Visits` context.
  """

  @doc """
  Generate a visit.
  """
  def visit_fixture(attrs \\ %{}) do
    {:ok, visit} =
      attrs
      |> Enum.into(%{
        date_time: ~U[2024-08-04 21:51:00Z]
      })
      |> Emr.Visits.create_visit()

    visit
  end
end
