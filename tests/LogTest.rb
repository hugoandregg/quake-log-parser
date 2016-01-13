require 'test/unit'
load 'Log.rb'
load 'Means.rb'

class LogTest < Test::Unit::TestCase
	def test_initialize_without_a_file
		assert_raises ArgumentError do
			log = Log.new('no_file.log')
		end
	end

	def test_add_game
		log = Log.new('tests/test_logs/add_player.log')
		log.read_log
		assert_equal(1, log.games.length)
	end

	def test_add_player
		log = Log.new('tests/test_logs/add_player.log')
		log.read_log
		assert_equal(1, log.games.first().players.length)
	end

	def test_change_name
		log = Log.new('tests/test_logs/change_name.log')
		log.read_log
		assert_equal('Mocinha', log.games.first().players.first().name)
	end

	def test_kill
		log = Log.new('tests/test_logs/kill.log')
		log.read_log
		assert_equal(1, log.games.first().total_kills)
		assert_equal(1, log.games.first().players.last().kills)
	end

	def test_world_kill
		log = Log.new('tests/test_logs/world_kill.log')
		log.read_log
		assert_equal(1, log.games.first().total_kills)
		assert_equal(-1, log.games.first().players.first().kills)
	end

	def test_kill_by_mean
		log = Log.new('tests/test_logs/world_kill.log')
		log.read_log
		assert_equal(1, log.games.first().total_kills)
		assert_equal(1, log.games.first().kills_by_means[$means_of_death.key(19)])
	end
end