defmodule PeriscopeTesterTest do
  use ExUnit.Case

  import Periscope
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  @endpoint PeriscopeTestAppWeb.Endpoint

  setup _tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  test "all the things", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "hello periscope tester"

    periscope_view = which_liveview()
    [periscope_pid] = liveview_pids()

    assert periscope_view == view.module
    assert periscope_pid == view.pid
  end
end
