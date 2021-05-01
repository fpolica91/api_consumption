defmodule ConsumingApis.Users.Create do
  alias ConsumingApis.{User, Repo}

  def call(params) do
    changeset = User.changeset(params)
    with {:ok, %User{}} <- User.build(changeset),
         {:ok, %User{}} = user <- Repo.insert(changeset)
     do
      user
    end
  end
end
# %{email: "chloe@chloe2.com", name: "chloe", password: "12345"}
