defmodule PracticaLiveview.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email, :username])
    |> unique_constraint(:email,
    name: "users_email_index",
    message: "La cuenta ya existe. Por favor inicie sesion."
    )
    |> unique_constraint(:username,
      name: "users_username_index",
      message: "El username esta en uso. Por favor use otro."
    )
  end
end
