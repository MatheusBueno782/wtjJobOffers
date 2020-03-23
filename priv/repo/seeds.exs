# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WtjJobOffers.Repo.insert!(%WtjJobOffers.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias WtjJobOffers.Repo
alias WtjJobOffers.Jobs.Offer

NimbleCSV.define(JobsParser, separator: ",", escape: "\"")

File.stream!("data/technical-test-jobs.csv")
|> JobsParser.parse_stream()
|> Enum.reject(fn line -> "" in line end)
|> Enum.each(fn [prof_id, contract, desc, lat, long] ->
  Repo.insert!(%Offer{
    profession_id: String.to_integer(prof_id),
    contract: contract,
    description: desc,
    latitude: String.to_float(lat),
    longitude: String.to_float(long)
  })
end)
