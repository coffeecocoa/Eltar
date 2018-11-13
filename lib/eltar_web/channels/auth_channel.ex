

defmodule EltarWeb.AuthChannel  do
  use EltarWeb, :channel

  def join("authenticated:lobby", _params, socket) do
    if socket.assigns[:user_id] do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
  end
 end
end