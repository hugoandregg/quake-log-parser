class Player
	attr_accessor :number, :name, :kills

	def initialize(number, name)
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