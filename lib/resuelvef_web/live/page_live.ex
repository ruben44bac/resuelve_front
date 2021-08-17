defmodule ResuelvefWeb.PageLive do
  @moduledoc """
    This module is the principal menu
  """

  use ResuelvefWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
