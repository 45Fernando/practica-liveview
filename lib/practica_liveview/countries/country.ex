defmodule PracticaLiveview.Countries.Country do
  use Ecto.Schema
  import Ecto.Changeset

  schema "countries" do
    field :name, :string

    timestamps()

    has_many :provinces, PracticaLiveview.Provinces.Province, foreign_key: :countries_id
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
