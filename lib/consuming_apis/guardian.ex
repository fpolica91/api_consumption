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

  def refresh_token(token) do
    {:ok, _old_stuff, {new_token, _new_claims}} = refresh(token)
    {:ok, new_token}
  end


  def authenticate(%{"id" => id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.call(%{"id" => id}),
    true <- Pbkdf2.verify_pass(password, hash),
    {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: {12, :weeks})
      do
       {:ok, token}
    end
  end
end

# %ConsumingApis.User{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
#   email: "chloe@chloe2.com",
#   id: 6,
#   inserted_at: ~N[2021-05-01 00:37:35],
#   name: "chloe",
#   password: nil,
#   password_hash: "$pbkdf2-sha512$160000$MmrRm742JsvpIXXgUDQjUA$HbUTUBd0RzuouLJoeItFX/Ewpj7Q2hOZz0Ez3QltX6JlBhHIGAMrFNSms/lunobZtGNZAiwZOWpaND5.5joG7Q",
#   updated_at: ~N[2021-05-01 00:37:35]
# }
