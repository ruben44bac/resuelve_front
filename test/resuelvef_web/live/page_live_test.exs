defmodule ResuelvefWeb.PageLiveTest do
  use ResuelvefWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Bienvenido a la prueba del front"
    assert render(page_live) =~ "Bienvenido a la prueba del front"
  end


end
