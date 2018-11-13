defmodule Eltar.Topic.Link do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  schema "links" do
    field :description, :string
    field :title, :string
    field :url, :string
    #field :user_id, :id

    belongs_to :user, Eltar.User

    timestamps()
  end

  @url_format ~r/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\* \.-]*)*\/?/

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :title, :description])
    |> validate_required([:url, :title, :description])
    |> validate_format(:url, @url_format, message: "Invalid URL format")
    |> validate_length(:description, min: 5)
    |> validate_length(:title, min: 5)
    |> unique_constraint(:url, message: "URL already submitted")
  end

  def search(query,search_term) do
    wildcard_search = "%#{search_term}%"

    from link in query,
      # where: ilike(link.url, ^wildcard_search),
      # or_where: 
      where: ilike(link.title, ^wildcard_search),
      or_where: ilike(link.description, ^wildcard_search)
  end
end
