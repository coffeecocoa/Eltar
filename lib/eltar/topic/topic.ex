defmodule Eltar.Topic do
  @moduledoc """
  The Topic context.
  """

  import Ecto.Query, warn: false
  alias Eltar.Repo

  alias Eltar.Topic.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """

  
  def list_searchs(params) do
    search = get_in(params,["query"])

    Link
    |> Link.search(search)
    |> order_by(desc: :inserted_at)
    |> preload(:user)
    |> Repo.paginate(params)
  end

  def list_links(params) do
    Link 
    |> order_by(desc: :inserted_at) 
    |> preload(:user) 
    |> Repo.paginate(params)
  end

  @doc """
  Gets a single link.

  Raises `Ecto.NoResultsError` if the Link does not exist.

  ## Examples

      iex> get_link!(123)
      %Link{}

      iex> get_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_profile(id) do
    Link
    |> preload(:user)
    |> Repo.get!(id)
  end

  def get_link_with_user(id) do
    Link
    |> preload(:user)
    |> Repo.get!(id)
  end

  def get_link!(id) do
    Repo.get!(Link, id)
  end

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(conn,attrs \\ %{}) do
    changeset = conn.assigns.user
    |> Ecto.build_assoc(:links)
    |> Link.changeset(attrs)
    
    Repo.insert(changeset)
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{source: %Link{}}

  """
  def change_link(%Link{} = link) do
    Link.changeset(link, %{})
  end
end
