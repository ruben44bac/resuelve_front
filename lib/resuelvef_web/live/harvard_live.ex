defmodule ResuelvefWeb.HarvardLive do
  use ResuelvefWeb, :live_view
  alias Resuelvef.HarvardHandler

  def mount(_params, _session, socket) do
    send(self(), :after_join)
    {:ok, assign(socket,
      list: []
    )}
  end

  def handle_info(:after_join, socket) do
    get_list(0)
    {:noreply, socket}
  end

  def handle_info({:DOWN, _ref, :process, _pid, :normal}, socket) do
    {:noreply, socket}
  end

  def handle_info({_ref, %{list: list}}, socket) do
    list
    |> IO.inspect(label: "LIST ==>>> ")
    {:noreply, assign(socket, list: list, loading: false)}
  end

  defp get_list(page) do
    Task.async(fn ->
      list = page
        |> HarvardHandler.get_list
      %{list: list}
    end)
  end


end
