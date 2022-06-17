defmodule PeriscopeTestAppWeb.PageController do
  use PeriscopeTestAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
