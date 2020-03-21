# WELCOME TO THE JUNGLE TECHNICAL TEST
### Description

> This application implements the spec presented by **Welcome to the Jungle**.  The development  language chosen is **Erlang/Elixir** for the capacity it has to deal with a high amount of data, the maintainability, error resilience.    
>   
### First Exercise 
> The script **offers_by_category.exs**  display a formatted table containing the amount of job offers by continent.
> 
> In order to get the continents from geographical coordinates without having to use google Maps api [this solution](https://stackoverflow.com/questions/13905646/get-the-continent-given-the-latitude-and-longitude) was addapted to **Elixir**, it provides acceptable precision inside this exercise's scope. 

>  **Usage:** `mix run lib/scripts/offers_by_category.exs`

 ### Dependencies 
-  [pkinney](https://github.com/pkinney)/**[topo](https://github.com/pkinney/topo)**
 A Geometry library for Elixir that calculates spatial relationships between two geometries
 
 - [codedge-llc](https://github.com/codedge-llc)/**[scribe](https://github.com/codedge-llc/scribe)**
Pretty print tables of Elixir structs and maps

- [dashbitco](https://github.com/dashbitco)/**[nimble_csv](https://github.com/dashbitco/nimble_csv)**
A simple and fast CSV parsing and dumping library for Elixir.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


