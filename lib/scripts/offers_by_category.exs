# display a formated list containig the ammount of job offers by region:w

NimbleCSV.define(MyParser, separator: ",", escape: "\"")

# Polygons representing continent's areas {polygon,continent_name} 
continents = [
  {%Geo.Polygon{
     coordinates: [
       [
         {90, -168.75},
         {90, -10},
         {78.13, -10},
         {57.5, -37.5},
         {15, -30},
         {15, -75},
         {1.25, -82.5},
         {1.25, -105},
         {51, -180},
         {60, -180},
         {60, -168.75},
         {90, -168.75}
       ]
     ]
   }, "NORTH AMERICA"},
  {%Geo.Polygon{coordinates: [[{51.0, 166.6}, {51, 180}, {60, 180}, {51, 166.6}]]},
   "NORTH AMERICA"},
  {%Geo.Polygon{
     coordinates: [
       [
         {1.25, -105},
         {1.25, -82.5},
         {15, -75},
         {15, -30},
         {-60, -30},
         {-60, -105},
         {1.25, -105}
       ]
     ]
   }, "SOUTH AMERICA"},
  {%Geo.Polygon{
     coordinates: [
       [
         {90, -10},
         {90, 77.5},
         {42.5, 48.8},
         {42.5, 30},
         {40.79, 28.81},
         {41, 29},
         {40.55, 27.31},
         {40.4, 26.75},
         {40.05, 26.36},
         {39.17, 25.19},
         {35.46, 27.91},
         {33, 27.5},
         {38, 10},
         {35.42, -10},
         {28.25, -13},
         {15, -30},
         {57.5, -37.5},
         {78.13, -10},
         {90, -10}
       ]
     ]
   }, "EUROPE"},
  {%Geo.Polygon{
     coordinates: [
       [
         {15, -30},
         {28.25, -13},
         {35.42, -10},
         {38, 10},
         {33, 27.5},
         {31.74, 34.58},
         {29.54, 34.92},
         {27.78, 34.46},
         {11.3, 44.3},
         {12.5, 52},
         {-60, 75},
         {-60, -30},
         {15, -30}
       ]
     ]
   }, "AFRICA"},
  {%Geo.Polygon{
     coordinates: [
       [
         {-11.88, 110},
         {-10.27, 140},
         {-10, 145},
         {-30, 161.25},
         {-52.5, 142.5},
         {-31.88, 110},
         {-11.88, 110}
       ]
     ]
   }, "AUSTRALIA"},
  {%Geo.Polygon{
     coordinates: [
       [
         {90, 77.5},
         {42.5, 48.8},
         {42.5, 30},
         {40.79, 28.81},
         {41, 29},
         {40.55, 27.31},
         {40.4, 26.75},
         {40.05, 26.36},
         {39.17, 25.19},
         {35.46, 27.91},
         {33, 27.5},
         {31.74, 34.58},
         {29.54, 34.92},
         {27.78, 34.46},
         {11.3, 44.3},
         {12.5, 52},
         {-60, 75},
         {-60, 110},
         {-31.88, 110},
         {-11.88, 110},
         {-10.27, 140},
         {33.13, 140},
         {51, 166.6},
         {60, 180},
         {90, 180},
         {90, 77.5}
       ]
     ]
   }, "ASIA"},
  {%Geo.Polygon{
     coordinates: [[{90.0, -180}, {90, -168.75}, {60, -168.75}, {60, -180}, {90, -180}]]
   }, "ASIA"},
  {%Geo.Polygon{coordinates: [[{-60, -180}, {-60, 180}, {-90, 180}, {-90, -180}, {-60, -180}]]},
   "ANTARCTICA"}
]

get_continent = fn point ->
  {_, continent} =
    Enum.find(continents, {nil, nil}, fn {polygon, _} -> Topo.contains?(polygon, point) end)

  continent
end

# create a relation map between categories and jobs
id2group =
  File.stream!("data/technical-test-professions.csv")
  |> MyParser.parse_stream()
  |> Enum.reduce(%{}, fn [id, _, group], acc ->
    Map.put(acc, id, String.upcase(group))
  end)
  #|> IO.inspect()

# build the frequece map that will be used to draw the table
frequency_map =
  File.stream!("data/technical-test-jobs.csv")
  |> MyParser.parse_stream()
  |> Enum.reject(fn line -> "" in line end)
  |> Enum.reduce(%{}, fn [prof_id, _, _, lat, long], acc ->
    #IO.inspect({prof_id, String.to_float(lat), String.to_float(long)})

    case get_continent.(%{
           type: "Point",
           coordinates: {String.to_float(lat), String.to_float(long)}
         }) do
      nil ->
        acc

      continent ->
        group = id2group[prof_id]

        Map.update(acc, continent, %{"" => continent, "TOTAL" => 1,group => 1}, fn groups ->
          Map.update(groups, group, 1, &(&1 + 1))
          # continent's total
          |> Map.update!("TOTAL", &(&1 + 1))
        end)
        # group totals
        |> Map.update("TOTAL",%{""=> "TOTAL", "TOTAL" => 1,group => 1}, fn totals -> 
          Map.update(totals,group,1,&(&1 + 1))
          # global total
          |> Map.update!("TOTAL", &(&1 + 1))
        end)
    end
  end)
  # build table << Scribe saves lifes >>
frequency_map
  |> Map.values
  |> Scribe.format(style: Scribe.Style.Pseudo)
  |> String.replace("\""," ")
  |> String.replace("nil",IO.ANSI.yellow() <> "0" <> "  ")
  |> IO.puts 


