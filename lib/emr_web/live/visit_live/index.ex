defmodule EmrWeb.VisitLive.Index do
  use EmrWeb, :live_view

  alias Emr.Visits
  alias Emr.Visits.Visit

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :visits, Visits.list_visits())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Visit")
    |> assign(:visit, Visits.get_visit!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Visit")
    |> assign(:visit, %Visit{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Visits")
    |> assign(:visit, nil)
  end

  @impl true
  def handle_info({EmrWeb.VisitLive.FormComponent, {:saved, visit}}, socket) do
    {:noreply, stream_insert(socket, :visits, visit)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    visit = Visits.get_visit!(id)
    {:ok, _} = Visits.delete_visit(visit)

    {:noreply, stream_delete(socket, :visits, visit)}
  end
end
