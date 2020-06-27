defmodule PracticaLiveviewWeb.CountryLive.Index do
  use PracticaLiveviewWeb, :live_view

  alias PracticaLiveview.Countries
  alias PracticaLiveview.Countries.Country

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :countries, list_countries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Country")
    |> assign(:country, Countries.get_country!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Country")
    |> assign(:country, %Country{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Countries")
    |> assign(:country, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    country = Countries.get_country!(id)
    {:ok, _} = Countries.delete_country(country)

    {:noreply, assign(socket, :countries, list_countries())}
  end

  defp list_countries do
    Countries.list_countries()
  end
end
