class Game
	attr_accessor :kills, :players, :total_kills, :name, :kills_by_means

	def initialize(name)
		@name = name
		@total_kills = 0
		@players = []
		@kills = {}
		@kills_by_means = {}
	end

	def add_kill
		@total_kills += 1
	end

	def add_player(player)
		if !@players.include? player
			@players << player
		end
	end

	def find_player_by_id(id)
		@players.each do |player|
			if player.id == id
				return player
			end
		end

		return nil
	end

	def find_player_by_name(name)
		@players.each do |player|
			if player.name == name
				return player
			end
		end

		return nil
	end

	def format
		game = @name + ": {\n"
		game += "	total_kills: " + @total_kills.to_s + ";\n"
		game += "	players: " + @players.to_json + "\n"
		game += "	kills: " + @kills.to_json + "\n"
		game += "	kills_by_means: " + @kills_by_means.to_json + "\n"
		game += "}"
		
		return game
	end

	def ranking
		kills = @kills.sort_by {|k, v| v}.reverse
		ranking = "Ranking: \n"
		kills.each do |player, kill|
			ranking += player + " - " + kill.to_s + "\n"
		end

		return ranking
	end
end