defmodule ResuelvefWeb.HarvardLive do

  @moduledoc """
    This module is in charge of managing the liveview part of the app related to Harvard
  """
  use ResuelvefWeb, :live_view
  alias Resuelvef.HarvardHandler

  def mount(_params, _session, socket) do
    send(self(), :after_join)
    {:ok, assign(socket,
      list: [],
      info: nil,
      loading: true,
      loading_list: false,
      index: 0,
      selected: nil
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
    info = data["info"]
    {:noreply, assign(socket, list: (socket.assigns.list ++ list), info: info, loading: false, loading_list: false)}
  end

  def handle_event("more_list", _params, socket) do
    if (socket.assigns.list |> length) < socket.assigns.info["totalrecords"] do
      index = socket.assigns.index + 1
      index
      |> get_list()
      {:noreply, assign(socket, index: index, loading_list: true)}
    else
      {:noreply, socket}
    end
  end

  def handle_event("select_film", %{"id" => id}, socket) do
    id = id |> String.to_integer
    selected = socket.assigns.list
    |> Enum.find(fn l -> l["id"] == id end)
    {:noreply, assign(socket, selected: selected)}
  end

  def handle_event("select_img", %{"id" => id}, socket) do
    id = id |> String.to_integer
    img = socket.assigns.selected["images"]
    |> Enum.find(fn i -> i["imageid"] == id end)
    selected = socket.assigns.selected
    |> Map.put("primaryimageurl", img["baseimageurl"])
    {:noreply, assign(socket, selected: selected)}
  end

  def handle_event("close_detail", _params, socket) do
    {:noreply, assign(socket, selected: nil)}
  end

  defp get_list(page) do
    Task.async(fn ->
      data = page
        |> HarvardHandler.get_list
      %{data: data}
    end)
  end


end
