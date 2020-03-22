defmodule WtjJobOffersWeb.OfferView do
  use WtjJobOffersWeb, :view
  alias WtjJobOffersWeb.OfferView

  def render("index.json", %{offers: offers}) do
    %{data: render_many(offers, OfferView, "offer.json")}
  end

  def render("show.json", %{offer: offer}) do
    %{data: render_one(offer, OfferView, "offer.json")}
  end

  def render("offer.json", %{offer: offer}) do
    %{id: offer.id,
      profession_id: offer.profession_id,
      contract: offer.contract,
      description: offer.description,
      latitude: offer.latitude,
      longitude: offer.longitude}
  end
end
