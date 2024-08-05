defmodule EmrWeb.VisitLive.FormComponent do
  use EmrWeb, :live_component

  alias Emr.Visits

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage visit records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="visit-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:date_time]} type="datetime-local" label="Date time" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Visit</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{visit: visit} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Visits.change_visit(visit))
     end)}
  end

  @impl true
  def handle_event("validate", %{"visit" => visit_params}, socket) do
    changeset = Visits.change_visit(socket.assigns.visit, visit_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"visit" => visit_params}, socket) do
    save_visit(socket, socket.assigns.action, visit_params)
  end

  defp save_visit(socket, :edit, visit_params) do
    case Visits.update_visit(socket.assigns.visit, visit_params) do
      {:ok, visit} ->
        notify_parent({:saved, visit})

        {:noreply,
         socket
         |> put_flash(:info, "Visit updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_visit(socket, :new, visit_params) do
    case Visits.create_visit(visit_params) do
      {:ok, visit} ->
        notify_parent({:saved, visit})

        {:noreply,
         socket
         |> put_flash(:info, "Visit created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
