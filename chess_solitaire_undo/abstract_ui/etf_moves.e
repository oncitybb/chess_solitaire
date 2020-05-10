note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVES
inherit
	ETF_MOVES_INTERFACE
create
	make
feature -- command
	moves(row: INTEGER_32 ; col: INTEGER_32)
    	do
			-- perform some update on the model state
			if not model.board.game_started then
				model.board.seterrormessage("Error: Game not yet started")
			elseif model.board.gameover then
				model.board.seterrormessage("Error: Game already over")
			elseif row > 4 or row < 1 or col > 4 or col < 1 then
				model.board.seterrormessage("Error: ("+row.out+", "+col.out+") not a valid slot")
			elseif model.board.arrayboard[row,col] = 0 then
				model.board.seterrormessage("Error: Slot @ ("+row.out+", "+col.out+") not occupied")
			else
				model.board.movechess(row,col)
			end
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
