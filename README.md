# PeriscopeTester

```bash
$ mkdir priv
$ cd priv/
$ mix phx.new periscope_test_app --no-ecto --no-mailer --no-gettext --no-dashboard
```
```elixir
# mix.exs
  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
+     {:periscope_test_app, path: "./priv/periscope_test_app", only: [:test, :dev]}
    ]
  end
```
```bash
$ mkdir config/
$ touch config/config.exs
```
```elixir
# config/config.exs
+ import Config
+ import_config "../priv/periscope_test_app/config/config.exs"
```

