note
	description: "Summary description for {SETUPCHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SETUPCHESS
inherit
	COMMAND
create
	make_setupchess

feature
	chess: INTEGER_32
	row: INTEGER_32
	col: INTEGER_32
--	game_started : BOOLEAN
--	gameover :BOOLEAN
--	gamelose : BOOLEAN
--	gamewon: BOOLEAN

feature
	make_setupchess(c: INTEGER_32 ; r: INTEGER_32 ; co: INTEGER_32)
	do
		make
		chess := c
		row := r
		col := co
--		game_started := model.board.game_started
--		gameover := model.board.gameover
--		gamelose := model.board.gamelose
--		gamewon := model.board.gamewon


	end


	execute
	do

		model.board.addchesstoboard (chess, row, col)

	end


	undo
	do
		model.board.removeaddchess (row, col)
	end


end
