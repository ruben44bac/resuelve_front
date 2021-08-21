defmodule ResuelvefWeb.PageLive do
  @moduledoc """
    This module is the principal menu
  """

  use ResuelvefWeb, :live_view

  @spec mount(any, any, any) :: {:ok, any}
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
