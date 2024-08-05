defmodule Emr.VisitsTest do
  use Emr.DataCase

  alias Emr.Visits

  describe "visits" do
    alias Emr.Visits.Visit

    import Emr.VisitsFixtures

    @invalid_attrs %{date_time: nil}

    test "list_visits/0 returns all visits" do
      visit = visit_fixture()
      assert Visits.list_visits() == [visit]
    end

    test "get_visit!/1 returns the visit with given id" do
      visit = visit_fixture()
      assert Visits.get_visit!(visit.id) == visit
    end

    test "create_visit/1 with valid data creates a visit" do
      valid_attrs = %{date_time: ~U[2024-08-04 21:51:00Z]}

      assert {:ok, %Visit{} = visit} = Visits.create_visit(valid_attrs)
      assert visit.date_time == ~U[2024-08-04 21:51:00Z]
    end

    test "create_visit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Visits.create_visit(@invalid_attrs)
    end

    test "update_visit/2 with valid data updates the visit" do
      visit = visit_fixture()
      update_attrs = %{date_time: ~U[2024-08-05 21:51:00Z]}

      assert {:ok, %Visit{} = visit} = Visits.update_visit(visit, update_attrs)
      assert visit.date_time == ~U[2024-08-05 21:51:00Z]
    end

    test "update_visit/2 with invalid data returns error changeset" do
      visit = visit_fixture()
      assert {:error, %Ecto.Changeset{}} = Visits.update_visit(visit, @invalid_attrs)
      assert visit == Visits.get_visit!(visit.id)
    end

    test "delete_visit/1 deletes the visit" do
      visit = visit_fixture()
      assert {:ok, %Visit{}} = Visits.delete_visit(visit)
      assert_raise Ecto.NoResultsError, fn -> Visits.get_visit!(visit.id) end
    end

    test "change_visit/1 returns a visit changeset" do
      visit = visit_fixture()
      assert %Ecto.Changeset{} = Visits.change_visit(visit)
    end
  end
end
