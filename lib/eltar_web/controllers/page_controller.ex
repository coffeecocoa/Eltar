defmodule EltarWeb.PageController do
  use EltarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", page_title: "Eltar")
  end
end
