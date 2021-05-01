defmodule ConsumingApis.Guardian do
  use Guardian, otp_app: :consuming_apis
  alias ConsumingApis.User
  alias ConsumingApis.Users.Get, as: UserGet


  def subject_for_token(%User{id: id}, _claims) do
    {:ok, id}
  end


  def resource_from_claims(claims) do
    claims
    |>Map.get("sub")
    |>UserGet.call()
  end

  def authenticate(%{"id" => id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.call(%{"id" => id}),
    true <- Pbkdf2.verify_pass(password, hash),
    {:ok, token, _claims} <- encode_and_sign(user)
      do
       {:ok, token}
    end
  end
end
