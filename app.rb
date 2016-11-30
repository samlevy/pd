require './boot'

client = NP::Client.new(
  game_id: ENV['GAME_ID'],
  auth: ENV['AUTH'],
)
response = client.get

fleets = response.fleets.select { |f| f.player_id.to_s != ENV['PLAYER_ID'] }

fleets.each do |fleet|
  next if fleet.orders.empty?

  order = fleet.orders.first

  attack = NP::Attack.new(
    player: fleet.player,
    fleet: fleet,
    star: order.destination_star
  )
  attack.alert
end

puts "FINISHED --- #{Time.now.utc}"