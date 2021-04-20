defmodule ConsumingApis.ViaGithub.Client do
  use Tesla
  alias Tesla.Env
  plug Tesla.Middleware.BaseUrl, "https://api.github.com/users/"
  plug Tesla.Middleware.Headers, [{"user-agent", "request"}]
  plug Tesla.Middleware.JSON


  def get_info(username) do
    IO.inspect(username)
    {:ok, response} = "#{username}/repos"
    |>get()
     handle_get(response)
  end

  def handle_get(%Env{status: 200, body: body }) do
    repos = Enum.map(body, fn item ->
        %{
          "id" => item["id"],
          "name" => item["name"],
          "description" => item["description"],
          "stargazers" => item["stargazer"],
          "html_url" => item["html_url,"]
        }
      end)

      {:ok, repos}

  end

end
