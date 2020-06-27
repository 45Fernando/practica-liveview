defmodule PracticaLiveviewWeb.ProvinceLive.FormComponent do
  use PracticaLiveviewWeb, :live_component

  alias PracticaLiveview.Provinces

  @impl true
  def update(%{province: province} = assigns, socket) do
    changeset = Provinces.change_province(province)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"province" => province_params}, socket) do
    changeset =
      socket.assigns.province
      |> Provinces.change_province(province_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"province" => province_params}, socket) do
    save_province(socket, socket.assigns.action, province_params)
  end

  defp save_province(socket, :edit, province_params) do
    case Provinces.update_province(socket.assigns.province, province_params) do
      {:ok, _province} ->
        {:noreply,
         socket
         |> put_flash(:info, "Provincia actualizada exitosamente")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_province(socket, :new, province_params) do
    case Provinces.create_province(province_params) do
      {:ok, _province} ->
        {:noreply,
         socket
         |> put_flash(:info, "Provincia creada exitosamente")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
