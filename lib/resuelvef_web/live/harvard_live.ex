defmodule ResuelvefWeb.HarvardLive do
  use ResuelvefWeb, :live_view
  alias Resuelvef.HarvardHandler

  def mount(_params, _session, socket) do
    send(self(), :after_join)
    {:ok, assign(socket,
      list: [],
      info: nil,
      loading: true,
      loading_list: false,
      index: 0
    )}
  end

  def handle_info(:after_join, socket) do
    socket.assigns.index
    |> get_list()
    {:noreply, socket}
  end

  def handle_info({:DOWN, _ref, :process, _pid, :normal}, socket) do
    {:noreply, socket}
  end

  def handle_info({_ref, %{data: data}}, socket) do
    list = data["records"]
    |> IO.inspect(label: "LIST ==>>> ")
    info = data["info"]
    {:noreply, assign(socket, list: (socket.assigns.list ++ list), info: info, loading: false)}
  end

  def handle_event("more_list", _params, socket) do
    index = socket.assigns.index + 1
    index
    |> get_list()
    {:noreply, assign(socket, index: index, loading_list: true)}
  end

  defp get_list(page) do
    Task.async(fn ->
      data = page
        |> HarvardHandler.get_list
      %{data: data}
    end)
  end


end
