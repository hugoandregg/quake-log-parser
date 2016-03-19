class Player
	attr_accessor :id, :name, :kills

	def initialize(id, name)
		@id = id
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