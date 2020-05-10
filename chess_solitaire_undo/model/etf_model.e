note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty
			i := 0
			create board.make
		end


feature -- model attributes
	s : STRING
	i : INTEGER
	board : BOARD


feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		require
			game_started:
				board.game_started
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_empty
			--print out first line with total chess number is board
			Result.append ("  # of chess pieces on board: " + board.getchessnumber + "%N")
			--print out second line with situation for baord
			Result.append (board.out)
		end

end




