defmodule WtjJobOffers.Jobs.Offer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "offers" do
    field :contract, :string
    field :description, :string
    field :latitude, :float
    field :longitude, :float
    field :profession_id, :integer

    timestamps()
  end

  @doc false
  def changeset(offer, attrs) do
    offer
    |> cast(attrs, [:profession_id, :contract, :description, :latitude, :longitude])
    |> validate_required([:profession_id, :contract, :description, :latitude, :longitude])
  end
end
