defmodule ResuelvefWeb.GhibliLive do

  @moduledoc """
    This module is in charge of managing the liveview part of the app related to Ghibli
  """
  use ResuelvefWeb, :live_view

  alias Resuelvef.GhibliHandler

  @spec mount(any, any, Phoenix.LiveView.Socket.t()) :: {:ok, any}
  def mount(_params, _session, socket) do
    send(self(), :after_join)
    {:ok, assign(socket,
      loading: true,
      list: [],
      list_body: [],
      autocomplete: [],
      search: "",
      film_selected: nil
    )}
  end

  @spec handle_info(
          :after_join
          | {any, %{:list => any, optional(any) => any}}
          | {:DOWN, any, :process, any, :normal},
          any
        ) :: {:noreply, any}
  def handle_info(:after_join, socket) do
    get_list()
    {:noreply, socket}
  end

  def handle_info({:DOWN, _ref, :process, _pid, :normal}, socket) do
    {:noreply, socket}
  end

  def handle_info({_ref, %{list: list}}, socket) do
    {:noreply, assign(socket, list: list, list_body: list, loading: false)}
  end

  @spec handle_event(<<_::64, _::_*8>>, any, Phoenix.LiveView.Socket.t()) :: {:noreply, any}
  def handle_event("search_change", %{"search" => ""}, socket) do
    {:noreply, assign(socket, search: "", autocomplete: [])}
  end

  def handle_event("search_change", %{"search" => search}, socket) do
    aux_search = search |> String.downcase
    autocomplete = socket.assigns.list
      |> Enum.filter(fn l -> l["title"] |> String.downcase |> String.contains?(aux_search) end)
    {:noreply, assign(socket, search: search, autocomplete: autocomplete)}
  end

  def handle_event("search_submit", %{"search" => search}, socket) do
    aux_search = search |> String.downcase
    list_body = socket.assigns.list
      |> Enum.filter(fn l -> l["title"] |> String.downcase |> String.contains?(aux_search) end)
    {:noreply, assign(socket, search: search, list_body: list_body)}
  end

  def handle_event("select_film", %{"id" => id}, socket) do
    film_selected = socket.assigns.list
      |> Enum.find(fn l -> l["id"] == id end)
    {:noreply, assign(socket, film_selected: film_selected, autocomplete: [])}
  end

  def handle_event("close_detail", _params, socket) do
    {:noreply, assign(socket, film_selected: nil)}
  end

  defp get_list() do
    Task.async(fn ->
      list = GhibliHandler.get_list
      %{list: list}
    end)
  end

  @spec get_img(any) :: any
  def get_img(id) do
    hard_img()
    |> Enum.member?(id)
    |> case do
      true -> id
      false -> "2baf70d1-42bb-4437-b551-e5fed5a87abe"
    end
  end

  defp hard_img(), do:
  [
    "2baf70d1-42bb-4437-b551-e5fed5a87abe",
    "12cfb892-aac0-4c5b-94af-521852e46d6a",
    "58611129-2dbc-4a81-a72f-77ddfc1b1b49",
    "ea660b10-85c4-4ae3-8a5f-41cea3648e3e",
    "4e236f34-b981-41c3-8c65-f8c9000b94e7",
    "ebbb6b7c-945c-41ee-a792-de0e43191bd8",
    "ff24da26-a969-4f0e-ba1e-a122ead6c6e3",
    "0440483e-ca0e-4120-8c50-4c8cd9b965d6",
    "45204234-adfd-45cb-a505-a8e7a676b114"
  ]

end
