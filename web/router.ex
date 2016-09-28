defmodule Exdrive.Router do
  use Exdrive.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Exdrive do
    pipe_through :api

    post "/publish/:job", PublishController, :publish
    post "/work/:job", WorkController, :doit
  end
end
