defmodule EltarWeb.Plugs.SetUser do
	import Plug.Conn
	# import Phoenix.Controller

	alias Eltar.Repo
	alias Eltar.User 
	# alias Vids.Router.Helpers

	def init(options) do
		options
	end

	def call(conn,_params) do
		user_id = get_session(conn,:user_id)
		cond do
			user = user_id && Repo.get(User,user_id) ->
				assign(conn,:user,user)
			true ->
				assign(conn,:user,nil)				
		end
	end
end