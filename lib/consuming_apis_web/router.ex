defmodule ConsumingApisWeb.Router do
  use ConsumingApisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ConsumingApisWeb do
    pipe_through :api
    get "/repos/:name", GithubController, :show
    post "/user/create", UsersController, :create
    post "/user/auth", UsersController, :auth
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ConsumingApisWeb.Telemetry
    end
  end
end

# list =[
#   %{name: "roger", last_name: "peters", age: 22},
#   %{name: "roger", last_name: "peters", age: 22},
#   %{name: "roger", last_name: "peters", age: 22},
#   %{name: "roger", last_name: "peters", age: 22}
# ]
# Enum.map(list,
#   fn entry -> Enum.map(entry, fn {k, v} -> IO.puts(k, v)
#   end)
# end)
