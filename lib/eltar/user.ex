defmodule Eltar.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :avatar, :string
    field :email, :string
    field :login, :string
    field :name, :string
    field :provider, :string
    field :token, :string

    has_many :links, Eltar.Topic.Link
    
    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :avatar, :email, :provider, :token, :login])
    |> validate_required([:name, :avatar, :email, :provider, :token, :login])
  end
end
