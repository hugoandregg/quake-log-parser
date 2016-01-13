require 'test/unit'
load 'Player.rb'

class PlayerTest < Test::Unit::TestCase
	def setup
		@player = Player.new(2, "zeh")
	end

	def test_initialize
		assert_equal(2, @player.id)
		assert_equal("zeh", @player.name)
		assert_equal(0, @player.kills)
	end

	def test_negative_id
		player = Player.new(-2, "zeh")
		assert_equal(-2, player.id)
	end

	def test_to_string
		assert_equal("zeh", @player.to_s)
	end

	def test_no_name_given
		assert_raises ArgumentError do
			player = Player.new(1)
		end
	end

	def test_add_kill
		@player.add_kill
		assert_equal(1, @player.kills)
	end

	def test_minus_kill
		@player.minus_kill 
		assert_equal(-1, @player.kills)
	end
end