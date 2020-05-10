note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_START_GAME
inherit
	ETF_START_GAME_INTERFACE
create
	make
feature -- command
	start_game
    	do
			-- perform some update on the model state
			if model.board.game_started then
				model.board.seterrormessage ("Error: Game already started")
			else
				model.board.startgame
			end
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
