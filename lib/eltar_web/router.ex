defmodule EltarWeb.Router do
  use EltarWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug EltarWeb.Plugs.SetUser
    plug :put_user_token
  end
  defp put_user_token(conn, _) do
      if current_user = conn.assigns[:user] do
         token = Phoenix.Token.sign(conn, "key", current_user.id)
         assign(conn, :user_token, token)
       else
         conn
       end
  end
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EltarWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/@:id", LinkController, :profile

    get "/links/search", LinkController, :search

    resources "/links", LinkController    
  end

  scope "/auth", EltarWeb do
    pipe_through :browser # Use the default browser stack

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request # request funcion are created in ueberauth library
    get "/:provider/callback", AuthController, :callback
    
  end


  # Other scopes may use custom stacks.
  # scope "/api", EltarWeb do
  #   pipe_through :api
  # end
end
