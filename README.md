# PeriscopeTester

```bash
mkdir priv
cd priv/
mix phx.new periscope_test_app --no-ecto --no-mailer --no-gettext --no-dashboard
cd ..
```

```elixir
# mix.exs
defp deps do
  [
    {:floki, ">= 0.30.0", only: :test},
    {:periscope, ">= 0.0.0"},
    {:periscope_test_app, path: "./priv/periscope_test_app", only: [:test, :dev]}
  ]
end
```

```bash
mkdir config/
touch config/config.exs
```

```elixir
# config/config.exs
import Config
import_config "../priv/periscope_test_app/config/config.exs"
```

Make these changes to the fresh Phoenix app
```diff
diff --git a/priv/periscope_test_app/config/config.exs b/priv/periscope_test_app/config/config.exs
index 008792c..b13d7f6 100644
--- a/priv/periscope_test_app/config/config.exs
+++ b/priv/periscope_test_app/config/config.exs
@@ -24,11 +24,6 @@ config :esbuild,
     env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
   ]
 
-# Configures Elixir's Logger
-config :logger, :console,
-  format: "$time $metadata[$level] $message\n",
-  metadata: [:request_id]
-
 # Use Jason for JSON parsing in Phoenix
 config :phoenix, :json_library, Jason
 
diff --git a/priv/periscope_test_app/config/dev.exs b/priv/periscope_test_app/config/dev.exs
index a3a994b..31e37b4 100644
--- a/priv/periscope_test_app/config/dev.exs
+++ b/priv/periscope_test_app/config/dev.exs
@@ -11,7 +11,7 @@ config :periscope_test_app, PeriscopeTestAppWeb.Endpoint,
   # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
   http: [ip: {127, 0, 0, 1}, port: 4000],
   check_origin: false,
-  code_reloader: true,
+  code_reloader: false,
   debug_errors: true,
   secret_key_base: "EK9TUwlgLKbdOAwPrTiDjiCAEwS62vuvjHN6jB1/RDBaN9x6KSj+7wIhCUMOktP8",
   watchers: [
diff --git a/priv/periscope_test_app/lib/periscope_test_app_web/endpoint.ex b/priv/periscope_test_app/lib/periscope_test_app_web/endpoint.ex
index 4d1e3b7..e3e0ee0 100644
--- a/priv/periscope_test_app/lib/periscope_test_app_web/endpoint.ex
+++ b/priv/periscope_test_app/lib/periscope_test_app_web/endpoint.ex
@@ -23,14 +23,6 @@ defmodule PeriscopeTestAppWeb.Endpoint do
     only: ~w(assets fonts images favicon.ico robots.txt)
   )
 
-  # Code reloading can be explicitly enabled under the
-  # :code_reloader configuration of your endpoint.
-  if code_reloading? do
-    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
-    plug(Phoenix.LiveReloader)
-    plug(Phoenix.CodeReloader)
-  end
-
   plug(Plug.RequestId)
   plug(Plug.Telemetry, event_prefix: [:phoenix, :endpoint])
```

Add a simple `LiveView`
```bash
mkdir priv/periscope_test_app/lib/periscope_test_app_web/live/
touch priv/periscope_test_app/lib/periscope_test_app_web/live/app_live.ex
```

```elixir
# priv/periscope_test_app/lib/periscope_test_app_web/router.ex
scope "/", PeriscopeTestAppWeb do
  pipe_through :browser

  live "/", AppLive
end

# priv/periscope_test_app/lib/periscope_test_app_web/live/app_live.ex
defmodule PeriscopeTestAppWeb.AppLive do
  use PeriscopeTestAppWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <p><%= @message %></p>
    """
  end

  @impl true
  def mount(_, _, socket) do
    {:ok, assign(socket, :message, "hello periscope tester")}
  end
end
```

Write some tests!
```elixir
# test/periscope_tester_test.exs
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
```