# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  User.destroy_all
  user1 = User.create(username: 'Tk')
  user2 = User.create(username: 'Foppylau')
  user3 = User.create(username: 'Nyxon')
  user4 = User.create(username: 'RebekahLiu')
  user5 = User.create(username: 'Ikickyoass')

  Artwork.destroy_all
  artwork1 = Artwork.create(title: 'Ruby 101', image_url: "cat1.jpg", artist_id: user1.id)
  artwork2 = Artwork.create(title: 'Ruby 102', image_url: "cat2.jpg", artist_id: user2.id)
  artwork3 = Artwork.create(title: 'Ruby 103', image_url: "cat3.jpg", artist_id: user3.id)
  artwork4 = Artwork.create(title: 'Ruby 101 Attempt: 2', image_url: "cat4.jpg", artist_id: user1.id)


  ArtworkShare.destroy_all
  ArtworkShare.create(viewer_id: user1.id, artwork_id: artwork2.id)
  ArtworkShare.create(viewer_id: user2.id, artwork_id: artwork2.id)
  ArtworkShare.create(viewer_id: user4.id, artwork_id: artwork1.id)
  ArtworkShare.create(viewer_id: user4.id, artwork_id: artwork2.id)
  ArtworkShare.create(viewer_id: user5.id, artwork_id: artwork3.id)

end
