defmodule PracticaLiveview.Repo.Migrations.CreateProvinces do
  use Ecto.Migration

  def change do
    create table(:provinces) do
      add :name, :string
      add :countries_id , references :countries

      timestamps()
    end

  end
end
