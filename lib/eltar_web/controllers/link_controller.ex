defmodule EltarWeb.LinkController do
  use EltarWeb, :controller

  alias Eltar.Topic
  alias Eltar.Topic.Link

  plug EltarWeb.Plugs.RequireAuth when action in [:create, :delete, :edit, :update, :new]
  plug :check_topic_owner when action in [:update, :edit, :delete]


  def profile(conn,%{"id" => id}) do
    link = Topic.get_profile(id)
    render(conn, "profile.html", page_title: link.user.login <> " - Eltar",link: link)
  end

  def search(conn, params) do
    
    links = Topic.list_searchs(params)

    search = get_in(params,["query"])

    render(conn,"search.html", page_title: "Search #{search} - Eltar" , 
      links: links.entries,
      page: links,
      query: search)
  end

  def index(conn, params) do
    links = Topic.list_links(params)
    render(conn, "index.html", 
      page_title: "Links - Eltar", 
      page: links)
  end

  def new(conn, _params) do
    changeset = Topic.change_link(%Link{})
    render(conn, "new.html", page_title: "New Links - Eltar", changeset: changeset)
  end

  def create(conn, %{"link" => link_params}) do
    case Topic.create_link(conn,link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: link_path(conn, :show, link))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", page_title: "Oops - Eltar", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Topic.get_link_with_user(id)
    render(conn, "show.html", page_title: link.title <> " - Eltar",link: link)
  end

  def edit(conn, %{"id" => id}) do
    link = Topic.get_link!(id)
    changeset = Topic.change_link(link)
    render(conn, "edit.html", page_title: "Edit Link - Eltar" ,link: link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Topic.get_link!(id)

    case Topic.update_link(link, link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link updated successfully.")
        |> redirect(to: link_path(conn, :show, link))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", page_title: "Oops - Eltar", link: link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Topic.get_link!(id)
    {:ok, _link} = Topic.delete_link(link)

    conn
    |> put_flash(:info, "Link deleted successfully.")
    |> redirect(to: link_path(conn, :index))
  end

  def check_topic_owner(conn,_params) do
    %{params: %{"id" => link_id}} = conn
    if Topic.get_link!(link_id).user_id == conn.assigns[:user].id or Topic.get_link!(link_id).user_id == nil do
      conn
    else
      conn
      |> put_flash(:error,"You cannot access that")
      |> redirect(to: link_path(conn,:index))
      |> halt()
    end
  end
end
