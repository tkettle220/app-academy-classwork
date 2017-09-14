
json.pokemon do
  json.extract! @pokemon, :id, :name, :attack, :defense, :image_url, :moves, :poke_type
  json.item_ids @pokemon.items.map(&:id)
end
