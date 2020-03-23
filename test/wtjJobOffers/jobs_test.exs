defmodule WtjJobOffers.JobsTest do
  use WtjJobOffers.DataCase

  alias WtjJobOffers.Jobs

  describe "offers" do
    alias WtjJobOffers.Jobs.Offer

    @valid_attrs %{
      contract: "some contract",
      description: "some description",
      latitude: 120.5,
      longitude: 120.5,
      profession_id: 42
    }
    @update_attrs %{
      contract: "some updated contract",
      description: "some updated description",
      latitude: 456.7,
      longitude: 456.7,
      profession_id: 43
    }
    @invalid_attrs %{
      contract: nil,
      description: nil,
      latitude: nil,
      longitude: nil,
      profession_id: nil
    }

    def offer_fixture(attrs \\ %{}) do
      {:ok, offer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jobs.create_offer()

      offer
    end

    test "list_offers/0 returns all offers" do
      offer = offer_fixture()
      assert Jobs.list_offers() == [offer]
    end

    test "get_offer!/1 returns the offer with given id" do
      offer = offer_fixture()
      assert Jobs.get_offer!(offer.id) == offer
    end

    test "create_offer/1 with valid data creates a offer" do
      assert {:ok, %Offer{} = offer} = Jobs.create_offer(@valid_attrs)
      assert offer.contract == "some contract"
      assert offer.description == "some description"
      assert offer.latitude == 120.5
      assert offer.longitude == 120.5
      assert offer.profession_id == 42
    end

    test "create_offer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_offer(@invalid_attrs)
    end

    test "update_offer/2 with valid data updates the offer" do
      offer = offer_fixture()
      assert {:ok, %Offer{} = offer} = Jobs.update_offer(offer, @update_attrs)
      assert offer.contract == "some updated contract"
      assert offer.description == "some updated description"
      assert offer.latitude == 456.7
      assert offer.longitude == 456.7
      assert offer.profession_id == 43
    end

    test "update_offer/2 with invalid data returns error changeset" do
      offer = offer_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_offer(offer, @invalid_attrs)
      assert offer == Jobs.get_offer!(offer.id)
    end

    test "delete_offer/1 deletes the offer" do
      offer = offer_fixture()
      assert {:ok, %Offer{}} = Jobs.delete_offer(offer)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_offer!(offer.id) end
    end

    test "change_offer/1 returns a offer changeset" do
      offer = offer_fixture()
      assert %Ecto.Changeset{} = Jobs.change_offer(offer)
    end
  end
end
