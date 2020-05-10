note
	description: "Summary description for {MOVEANDCAPTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOVEANDCAPTURE
inherit
	COMMAND
		redefine
			returnmoveclass
		end
create
	make_moveandcap

feature
	row1,row2,col1,col2 : INTEGER
	chess1,chess2: INTEGER


feature
	make_moveandcap(r1: INTEGER_32 ; c1: INTEGER_32 ; r2: INTEGER_32 ; c2: INTEGER_32;ch1 : INTEGER; ch2: INTEGER)
		do
			make
			row1 := r1
			row2 := r2
			col1 := c1
			col2 := c2
			chess1 := ch1
			chess2 := ch2
		end

	undo
		do

			model.board.undomoveandcap (row1, row2, col1, col2, chess1, chess2)

		end

	execute
		do
			model.board.moveandcap (row1, col1, row2, col2)
		end

	returnmoveclass : BOOLEAN
		do
			Result := True
		end

end
