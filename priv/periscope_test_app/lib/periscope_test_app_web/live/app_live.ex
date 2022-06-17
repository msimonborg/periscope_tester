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
