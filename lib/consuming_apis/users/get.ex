defmodule ConsumingApis.Users.Get do
  alias ConsumingApis.{User, Repo}


  def test do
    list = [
      %{name: "roger", last_name: "peters", age: 22},
      %{name: "roger", last_name: "peters", age: 22},
      %{name: "roger", last_name: "peters", age: 22},
      %{name: "roger", last_name: "peters", age: 22}
    ]

    Enum.map(list, fn entry ->
      Enum.map(entry, fn{k,v} ->
        "the key #{k}, the value #{v}"
      end)
    end)
  end

  def call(%{"id" => id}) do
    case Repo.get(User, id) do
      nil -> {:error, "user cannot be found"}
      user -> {:ok, user}
    end
  end
end
