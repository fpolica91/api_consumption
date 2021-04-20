defmodule ConsumingApisWeb.GithubController do
  use ConsumingApisWeb, :controller
  alias ConsumingApis.ViaGithub.Client


  def show(connection, %{"name" => username}) do
    with repos <- Client.get_info(username)  do
      connection
      |>put_status(:ok)
      |>json(repos)
    end
  end
end
