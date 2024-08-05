defmodule Emr.Repo.Migrations.CreateVisits do
  use Ecto.Migration

  def change do
    create table(:visits) do
      add :date_time, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
