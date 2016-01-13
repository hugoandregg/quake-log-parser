require 'test/unit'
load 'Game.rb'
load 'Player.rb'

class GameTest < Test::Unit::TestCase
	def setup
		@game = Game.new("game_1")
	end

	def test_initialize	
		assert_equal(0, @game.total_kills)
		assert_equal([], @game.players)
		assert_equal({}, @game.kills)
		assert_equal({}, @game.kills_by_means)
	end

	def test_add_kills
		@game.add_kill
		assert_equal(1, @game.total_kills)
	end

	def test_find_player_by_id_without_players
		assert_equal(nil, @game.find_player_by_id(2))
	end

	def test_find_player_by_name_without_players
		assert_equal(nil, @game.find_player_by_name("zeh"))
	end

	def test_add_player
		@game.add_player(Player.new(2, "zeh"))
		assert_equal(1, @game.players.length)
	end

	def test_add_players
		@game.add_player(Player.new(2, "zeh"))
		@game.add_player(Player.new(2, "zeh"))
		assert_equal(2, @game.players.length)
	end

	def test_add_same_player
		player = Player.new(2, "zeh")
		@game.add_player(player)
		@game.add_player(player)
		assert_equal(1, @game.players.length)
	end

	def test_find_player_by_name
		@game.add_player(Player.new(2, "zeh"))
		@game.add_player(Player.new(3, "zah"))
		@game.add_player(Player.new(4, "zuh"))
		assert_equal(2, @game.find_player_by_name("zeh").id)
	end

	def test_find_player_by_id
		@game.add_player(Player.new(2, "zeh"))
		@game.add_player(Player.new(3, "zah"))
		@game.add_player(Player.new(4, "zuh"))
		assert_equal("zeh", @game.find_player_by_id(2).name)
	end
end