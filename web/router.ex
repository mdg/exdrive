defmodule Exdrive.Router do
  use Exdrive.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/queue", Exdrive do
    pipe_through :api

    post "/publish/:prio/:job", PublishController, :publish
    get "/stats", StatsController, :stats
    post "/work/:job", WorkController, :doit
  end
end
