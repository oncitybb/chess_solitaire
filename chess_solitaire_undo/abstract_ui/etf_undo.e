note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
create
	make
feature -- command
	undo
    	do
			-- perform some update on the model state
			if (model.board.history.arraylist.count = 0) or (model.board.history.before) then
				model.board.seterrormessage("Error: Nothing to undo")
			else
				model.board.undo
			end
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
