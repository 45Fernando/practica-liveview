defmodule PracticaLiveviewWeb.ProvinceLive.Index do
  use PracticaLiveviewWeb, :live_view

  alias PracticaLiveview.Provinces
  alias PracticaLiveview.Provinces.Province
  alias PracticaLiveview.Countries

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :provinces, list_provinces())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Editar Provincia")
    |> assign(:province, Provinces.get_province!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Nueva Provincia")
    |> assign(:province, %Province{})
    |> assign(:countries, list_countries())
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Provinces")
    |> assign(:province, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    province = Provinces.get_province!(id)
    {:ok, _} = Provinces.delete_province(province)

    {:noreply, assign(socket, :provinces, list_provinces())}
  end

  defp list_provinces do
    Provinces.list_provinces()
  end

  defp list_countries do
    Countries.list_countries()
    |> Enum.map(&{&1.name, &1.id})
  end
end
