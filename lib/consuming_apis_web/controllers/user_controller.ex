defmodule ConsumingApisWeb.UsersController do
  use ConsumingApisWeb, :controller
  alias ConsumingApis.Guardian, as: Auth
  alias ConsumingApis.User
  alias ConsumingApis.Users.Create, as: UserCreate


def create(connection, params) do
  with {:ok, %User{} = user} <- UserCreate.call(params)  do
    connection
    |>put_status(:ok)
    |>json(user)
  end
end




  def auth(connection, %{"id" => id, "password" => password}) do
    with {:ok, token} <- Auth.authenticate(%{"id" => id, "password" => password})  do
      connection
      |>put_status(:ok)
      |>json(token)
    end
  end
end
