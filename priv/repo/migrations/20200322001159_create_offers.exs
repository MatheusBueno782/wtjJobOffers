defmodule WtjJobOffers.Repo.Migrations.CreateOffers do
  use Ecto.Migration

  def change do
    create table(:offers) do
      add :profession_id, :integer
      add :contract, :string
      add :description, :string
      add :latitude, :float
      add :longitude, :float

      timestamps()
    end

  end
end
