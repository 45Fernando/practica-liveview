defmodule PracticaLiveview.Provinces.Province do
  use Ecto.Schema
  import Ecto.Changeset

  schema "provinces" do
    field :name, :string

    timestamps()

    belongs_to :countries, PracticaLiveview.Countries.Country, foreign_key: :countries_id
  end

  @doc false
  def changeset(province, attrs) do
    province
    |> cast(attrs, [:name, :countries_id])
    |> validate_required([:name])
    |> foreign_key_constraint(:countries_id)
  end
end
