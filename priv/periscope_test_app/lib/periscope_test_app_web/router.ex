defmodule PeriscopeTestAppWeb.Router do
  use PeriscopeTestAppWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {PeriscopeTestAppWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", PeriscopeTestAppWeb do
    pipe_through(:browser)

    live("/", AppLive)
  end

  # Other scopes may use custom stacks.
  # scope "/api", PeriscopeTestAppWeb do
  #   pipe_through :api
  # end
end
