require 'json'

class Game
	attr_accessor :kills, :players, :total_kills, :name

	def initialize(name)
		@name = name
		@total_kills = 0
		@players = []
		@kills = {}
	end

	def add_kills
		@total_kills += 1
	end

	def add_player(player)
		if !@players.include? player
			@players << player
		end
	end

	def find_player_by_number(number)
		@players.each do |player|
			if player.number == number
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


class Player
	attr_accessor :number, :name, :kills

	def initialize(number, name="")
		@number = number
		@name = name
		@kills = 0
	end

	def add_kill
		@kills += 1
	end

	def minus_kill
		@kills -= 1
	end

	def to_s
		@name
	end
end


class Log
	def initialize path 
		raise ArgumentError unless File.exists? path
		
		@log = File.open(path)
		@games = []
	end

	def read_log 
		@log.each_line do |line|
			if line.include? "InitGame"
				name = "game_" + (@games.length + 1).to_s
				@game = Game.new(name)
			end

			if line.include? "ClientUserinfoChanged"
				number = line.partition("ClientUserinfoChanged:").last[/\d+/]
				name = line[/n\\(.*?)\\t\\/, 1]

				player = @game.find_player_by_number(number)
				if player
					player.name = name unless player.name == name
				else
					player = @game.find_player_by_name(name)
					if player
						player.number = number
					else
						@game.players << Player.new(number, name)
					end
				end
			end

			if line.include? "ClientDisconnect"
				number = line.partition("ClientDisconnect:").last[/\d+/]
				@game.find_player_by_number(number).number = 0
			end
			
			if line.include? "Kill"
				@game.add_kills
				numbers = line.partition("Kill:").last.scan(/\d+/)
				
				if numbers[0] == "1022"
					@game.find_player_by_number(numbers[1]).minus_kill
				else
					@game.find_player_by_number(numbers[0]).add_kill
				end
			end

			if line.include? "ShutdownGame"
				@games << @game
				@game = nil
			end
		end
	end

	def emit
		@games.each do |game|
			game.players.each do |player|
				game.kills[player.name] = player.kills
			end

			puts game.format
			puts game.ranking
		end
	end
end

log = Log.new(*ARGV)
log.read_log
log.emit