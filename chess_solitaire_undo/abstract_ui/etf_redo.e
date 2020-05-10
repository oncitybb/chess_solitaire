note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
create
	make
feature -- command
	redo
    	do
			-- perform some update on the model state
			if (model.board.history.index  >= model.board.history.arraylist.count) or ( model.board.history.after) then
				model.board.seterrormessage("Error: Nothing to redo")
			else
				model.board.redo
			end
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
