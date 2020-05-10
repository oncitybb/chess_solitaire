note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_CHESS
inherit
	ETF_SETUP_CHESS_INTERFACE
create
	make
feature -- command
	setup_chess(c: INTEGER_32 ; row: INTEGER_32 ; col: INTEGER_32)
		require else
			setup_chess_precond(c, row, col)
    	do
			-- perform some update on the model state
			if model.board.game_started or model.board.gameover then
				model.board.seterrormessage("Error: Game already started")
			elseif row > 4 or row < 1 or col > 4 or col < 1 then
				model.board.seterrormessage("Error: ("+row.out+", "+col.out+") not a valid slot")
			elseif model.board.arrayboard[row,col] /= 0 then
				model.board.seterrormessage("Error: Slot @ ("+row.out+", "+col.out+") already occupied")
			else
				model.board.addchesstoboard (c, row, col)
			end
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
