require "typhoeus"
require "pry-rails"

class PokemonController < ApplicationController

  def show
    # results_object = {
    #   message: "ok"
    # }
    # render(json: results_object)

    res = Typhoeus.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}", followlocation: true)
    pokemon_body = JSON.parse(res.body)

    res_giphy = Typhoeus.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV['POKE_KEY']}&q=#{pokemon_body["name"]}&rating=g", followlocation: true)
      giphy = JSON.parse(res_giphy.body)
      render json: {
      name: pokemon_body["name"],
      id: pokemon_body["id"],
      type: pokemon_body["types"].first["type"]["name"],
      giphy: giphy["data"].first['embed_url']
      }


    # body["name"] # should be "pikachu"
  end
end
