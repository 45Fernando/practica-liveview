defmodule PracticaLiveviewWeb.ProvinceLive.Show do
  use PracticaLiveviewWeb, :live_view

  alias PracticaLiveview.Provinces

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:province, Provinces.get_province!(id))}
  end

  defp page_title(:show), do: "Show Province"
  defp page_title(:edit), do: "Edit Province"
end
