defmodule Emr.Repo do
  use Ecto.Repo,
    otp_app: :emr,
    adapter: Ecto.Adapters.Postgres
end
