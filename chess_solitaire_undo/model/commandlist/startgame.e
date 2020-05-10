note
	description: "Summary description for {STARTGAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STARTGAME
inherit
	COMMAND
create
	make_startgame
feature
	make_startgame
		do
			make
		end

	undo
		do

			model.board.unstartgame

		end

	execute
		do

			model.board.startgame

		end
end
