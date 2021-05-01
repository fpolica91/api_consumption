defmodule ConsumingApis.Users.Get do
  alias ConsumingApis.{User, Repo}

  def call(%{"id" => id}) do
    case Repo.get(User, id) do
      nil -> {:error, "user cannot be found"}
      user -> {:ok, user}
    end
  end
end
