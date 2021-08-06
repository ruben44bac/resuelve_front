defmodule Resuelvef.Repo do
  use Ecto.Repo,
    otp_app: :resuelvef,
    adapter: Ecto.Adapters.Postgres
end
