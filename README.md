## WELCOME TO THE JUNGLE TECHNICAL TEST
### Description

> This application implements the spec presented by **Welcome to the Jungle**.  The development  language chosen is **Erlang/Elixir** for the capacity it has to deal with a high amount of data, the maintainability, error resilience. To create the api required at the third exercise the **Phoenix** framework was chosen for its simplicity and mature documentation.   

### First Exercise 
> The script **offers_by_category.exs**  display a formatted table containing the amount of job offers by continent.
> 
> In order to get the continents from geographical coordinates without having to use google Maps api [this solution](https://stackoverflow.com/questions/13905646/get-the-continent-given-the-latitude-and-longitude) was addapted to **Elixir**, it provides acceptable precision inside this exercise's scope. 

>  **Usage:** `mix run lib/scripts/offers_by_category.exs`

### Second Exercise

Elixir is naturally built to deal with a lot data and i/o. In the context of the reflection  proposed by this exercise and assuming:
-  new offers are added by calling an pre-existent API endpoint.
- When the API is called it logs the updated table(in the same format of the first exercise)
- we have to stock all new data in a data base.

We can certainly affirm there will be two bottlenecks in our application, both related to reading and writing in our database. 

The write problem can be solved by using Elixir's **tasks** or **workers**  to paralelize the writing process. Since **nimble_csv** returns a list, a `Task.async_stream/3` should do the job.

The get problem is a bit more complex. In order to build the table we have to perform a get_all in our database, as it grows linearly with time even if we paralelize this operation it will eventually not be enough. So the best option here is to create a **GenServer** who dumps the database into an **ets** table and updates it periodically. Our get_all will then be performed in our ets table and no more directly in our database.    

 This approach have many advantages:
- The update cost is constant since the database linearly grows in size.
- get elements in ets tables is extremely fast.
-  `:ets.lookup/2` and `:ets.insert/2` costs are constant.  

The limitations of this approach are: 
   - A new offer will only be outputted after a time period ( equal to the update period in the worst case).
   - Ets tables are not persistent and are stored in your ram, so it can't grow forever.

### Third Exercise

> To create the base for the API the pretty cool `phx.gen.json` was used
> 
> `mix phx.gen.json Jobs Offer offers profession_id:integer contract:string description:string latitude:float longitude:float`

> The API implements the spec by the `offers_in` endpoint, in can be used calling(GET)  `/api/offers_in/latitude/longitude/radius` as in the following example:
>
> Ex: http://localhost:4000/api/offers_in/39.3/118.2/100

> All other endpoints are only used for testing the database.
### Future Enhancements
- Integrate profession list to the database and use it to enhance the endpoint response.

- Integrate [bryanjos](https://github.com/bryanjos)/**[geo_postgis](https://github.com/bryanjos/geo_postgis)** dependency in order to enforce geographical coordinate fields and to be able to make queries using distance.

###  Phoenix instructions
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
 ### Dependencies 
-  [pkinney](https://github.com/pkinney)/**[topo](https://github.com/pkinney/topo)**
 A Geometry library for Elixir that calculates spatial relationships between two geometries
 
 - [codedge-llc](https://github.com/codedge-llc)/**[scribe](https://github.com/codedge-llc/scribe)**
Pretty print tables of Elixir structs and maps

- [dashbitco](https://github.com/dashbitco)/**[nimble_csv](https://github.com/dashbitco/nimble_csv)**
A simple and fast CSV parsing and dumping library for Elixir.
- [yltsrc](https://github.com/yltsrc)/**[geocalc](https://github.com/yltsrc/geocalc)**
A geospatial library for Elixir, handy to work with GPS coordinates  


