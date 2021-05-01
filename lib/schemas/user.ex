defmodule ConsumingApis.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias ConsumingApis.Repo
  @required_params [:name,:email, :password ]
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |>cast(params, @required_params)
    |>validate_required(@required_params)
    |>unique_constraint([:email])
    |>password_hash()
    # |>insert_user()
  end

  def build(changeset), do: apply_action(changeset, :create)


  # %Changeset {valid?: true, changes: %{password: password}}
  defp password_hash(%Changeset {valid?: true, changes: %{password: password}} = user) do
    change(user, Pbkdf2.add_hash(password))
  end

  defp password_hash(changeset), do: changeset


end
