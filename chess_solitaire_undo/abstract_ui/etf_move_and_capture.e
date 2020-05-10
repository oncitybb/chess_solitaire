note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_AND_CAPTURE
inherit
	ETF_MOVE_AND_CAPTURE_INTERFACE
create
	make
feature -- command
	move_and_capture(r1: INTEGER_32 ; c1: INTEGER_32 ; r2: INTEGER_32 ; c2: INTEGER_32)
    	do
			-- perform some update on the model state

			if not model.board.game_started then
				model.board.seterrormessage("Error: Game not yet started")
			elseif model.board.gameover then
				model.board.seterrormessage("Error: Game already over")
			elseif r1 > 4 or r1 < 1 or c1 > 4 or c1 < 1 then
				model.board.seterrormessage("Error: ("+r1.out+", "+c1.out+") not a valid slot")
			elseif r2 > 4 or r2 < 1 or c2 > 4 or c2 < 1 then
				model.board.seterrormessage("Error: ("+r2.out+", "+c2.out+") not a valid slot")
			elseif model.board.arrayboard[r1,c1] =0  then
				model.board.seterrormessage("Error: Slot @ ("+r1.out+", "+c1.out+") not occupied")
			elseif model.board.arrayboard[r2,c2] = 0 then
				model.board.seterrormessage("Error: Slot @ ("+r2.out+", "+c2.out+") not occupied")
			else
				model.board.moveandcap (r1, c1, r2, c2)
			end	
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
