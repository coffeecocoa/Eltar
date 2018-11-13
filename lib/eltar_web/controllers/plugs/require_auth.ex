defmodule EltarWeb.Plugs.RequireAuth do
	import Plug.Conn
	import Phoenix.Controller

	use EltarWeb, :controller

	def init(_conn) do
		
	end

	def init(_conn,_options) do
		
	end

	def call(conn,_params) do
		if conn.assigns[:user] do
			conn
		else
			conn
			|> put_flash(:error,"You must be logged in")
			|> redirect(to: page_path(conn,:index))
			|> halt()
		end
	end
end