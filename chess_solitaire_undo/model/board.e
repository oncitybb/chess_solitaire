note
	description: "Summary description for {BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

inherit
	ANY
		redefine
			out
		end

create
	make


feature
	arrayboard : ARRAY2[INTEGER_32]
	chessnumber : INTEGER
	game_started : BOOLEAN
	gameover : BOOLEAN
	gamelose : BOOLEAN
	gamewon: BOOLEAN
	error : BOOLEAN
	errormessage : STRING
	movingchessprint: BOOLEAN
	move: MOVE
	movingmap : STRING
	history : HISTORY
	undoredomode : BOOLEAN
	changetuple : BOOLEAN

feature -- basic
	make
		do
			create arrayboard.make_filled (0, 4, 4)
			chessnumber := 0
			game_started := False
			gameover := False
			gamewon := False
			gamelose := False
			error := False
			movingchessprint := False
			undoredomode := False
			changetuple := False
			errormessage := ""
			create movingmap.make_empty
			create move.make
			create history.make
		end

	startgame

		require
			game_not_started:
				not game_started
		local
			k : STARTGAME
		do
			if
				not undoredomode
			then
				create k.make_startgame
				k.getstatus(game_started,gamelose,gamewon,error, gameover)
				history.add (k)
			end
			game_started := True
			if chessnumber = 1 then
				gamewon := True
			elseif checklose then
				gamelose := True
			end

		end

	unstartgame
		require
			undo:
				undoredomode

		do

			game_started := False
			gamelose := False
			gamewon := False
		end

	seterrormessage(str : STRING)
		do
			error := True
			errormessage := errormessage + str + "%N"
		end


feature -- setupchess feature
	addchesstoboard(c: INTEGER_32 ; row: INTEGER_32 ; col: INTEGER_32)
		require
			row_and_col_correct:
				row < 5 and row > 0 and col > 0 and col < 5

			game_not_started:
				not game_started

			not_occupied:
				arrayboard[row,col] = 0
		-- put chess into board and increate the chess number on board
		local
			action : SETUPCHESS
		do
			if not undoredomode then
				create action.make_setupchess (c, row, col)
				action.getstatus(game_started,gamelose,gamewon,error, gameover)
				history.add (action)

			end
			arrayboard[row,col] := c
			chessnumber := chessnumber + 1



		end

	removeaddchess(row,col : INTEGER)
	require
		undo:
			undoredomode
		do
			arrayboard[row,col] := 0
			chessnumber := chessnumber - 1
		end

feature -- move
	movechess(row: INTEGER_32 ; col: INTEGER_32)
		require
			game_started:
				game_started

			game_not_over:
				not gameover

			row_and_col_correct:
				row < 5 and row > 0 and col > 0 and col < 5

			occupied:
				arrayboard[row,col] /= 0

		do
			create move.make
			move.makemovingmap (arrayboard[row,col], row, col)
			movingmap := move.out
		end

feature
	moveandcap(r1: INTEGER_32 ; c1: INTEGER_32 ; r2: INTEGER_32 ; c2: INTEGER_32)
		require
			game_started:
				game_started
			gameover:
				not gameover
			row_and_col_correct:
				r1 < 5 and r1 > 0 and c1 > 0 and c1 < 5 and r2 < 5 and r2 > 0 and c2 > 0 and c2 < 5
			occupied:
				arrayboard[r1,c1] /= 0 and arrayboard[r2,c2] /= 0
		local
			moveboard: MOVE
			checkboard: ARRAY2[INTEGER_32]
			name : STRING
			comman : MOVEANDCAPTURE
		do
				-- create a moving map for r1c1 and figure out able to move to r2c2 or not
				create moveboard.make
				moveboard.makemovingmap (arrayboard[r1,c1], r1, c1)
				checkboard := moveboard.returnboard
				if checkboard[r2,c2] /= 9 then
					create name.make_empty
					if arrayboard[r1,c1] = 1 then name.append ("K")
					elseif arrayboard[r1,c1] = 2 then name.append ("Q")
					elseif arrayboard[r1,c1] = 3 then name.append ("N")
					elseif arrayboard[r1,c1] = 4 then name.append ("B")
					elseif arrayboard[r1,c1] = 5 then name.append ("R")
					elseif arrayboard[r1,c1] = 6 then name.append ("P")
					end
					seterrormessage("Error: Invalid move of " + name + " from ("+r1.out+", "+c1.out+") to ("+r2.out+", "+c2.out+")")
				elseif not notblock(r1,c1,r2,c2,checkboard) then
					seterrormessage("Error: Block exists between ("+r1.out+", "+c1.out+") and ("+r2.out+", "+c2.out+")")
				else
					create comman.make_moveandcap (r1, c1, r2, c2, arrayboard[r1,c1], arrayboard[r2,c2])
					if not undoredomode then
						create comman.make_moveandcap (r1, c1, r2, c2, arrayboard[r1,c1], arrayboard[r2,c2])
						comman.getstatus(game_started,gamelose,gamewon,error, gameover)
						history.add (comman)
					end
					arrayboard[r2,c2] := arrayboard[r1,c1]
					arrayboard[r1,c1] := 0
					chessnumber := chessnumber - 1
					if chessnumber = 1 then
						gamewon := True
					elseif checklose then
						gamelose := True
					end



			end


		end


		notblock(r1: INTEGER_32 ; c1: INTEGER_32 ; r2: INTEGER_32 ; c2: INTEGER_32 ; checkboard: ARRAY2[INTEGER_32]): BOOLEAN
			local
				chess :INTEGER
				i : INTEGER
				j : INTEGER


			do
				chess := arrayboard[r1,c1]
				Result := False
				if chess = 1 then
					Result := True
				elseif chess = 2 then
					i := r1-r2
					j := c1-c2
					if i.abs = 1 and j.abs =1 then
						Result := True
					elseif i = 0 then
						Result := across c1 |..| c2 is k all k = c1 or k = c2 or arrayboard[r1,k] = 0 end
					elseif j = 0 then
						Result := across r1 |..| r2 is k all k = r1 or k = r2 or arrayboard[k,c1] = 0 end
					else
						if	(r1-r2)>0 then
							if (c1-c2)>0 then
								Result := across 1 |..| (i.abs) is a all (r1-a) = r2 or arrayboard[r1-a,c1-a] = 0 end
							else
								Result := across 1 |..| (i.abs) is a all (r1-a) = r2 or arrayboard[r1-a,c1+a] = 0 end
							end
						else
							if (c1-c2) > 0 then
								Result := across 1 |..| (i.abs) is a all (r1+a) = r2 or arrayboard[r1+a,c1-a] = 0 end
							else
								Result := across 1 |..| (i.abs) is a all (r1+a) = r2 or arrayboard[r1+a,c1+a] = 0 end
							end
						end
					end
				elseif chess = 3 then --bug at notblock k2.txt
					if (r1-r2)>0 then
						if (c1-c2)>0 then
							Result := 	across 1 |..| (r1-r2).abs is a all arrayboard[r1-a,c1] = 0 end
										and
										across 1 |..| (c1-c2).abs is b all arrayboard[r2, c2+b] = 0 end
						else
							Result := 	across 1 |..| (r1-r2).abs is a all arrayboard[r1-a,c1] = 0 end
										and
										across 1 |..| (c1-c2).abs is b all arrayboard[r2, c2-b] = 0 end
						end
					else
						if (c1-c2) > 0 then
							Result := 	across 1 |..| (r1-r2).abs is a all arrayboard[r1+a,c1] = 0 end
										and
										across 1 |..| (c1-c2).abs is b all arrayboard[r2, c2+b] = 0 end
						else
							Result := 	across 1 |..| (r1-r2).abs is a all arrayboard[r1+a,c1] = 0 end
										and
										across 1 |..| (c1-c2).abs is b all arrayboard[r2, c2-b] = 0 end
						end
					end

				elseif chess = 4 then
					if	(r1-r2)>0 then
						if (c1-c2)>0 then
							Result := across 1 |..| (r1-r2).abs is a all (r1-a) = r2 or arrayboard[r1-a,c1-a] = 0 end
						else
							Result := across 1 |..| (r1-r2).abs is a all (r1-a) = r2 or arrayboard[r1-a,c1+a] = 0 end
						end
					else
						if (c1-c2) > 0 then
							Result := across 1 |..| (r1-r2).abs is a all (r1+a) = r2 or arrayboard[r1+a,c1-a] = 0 end
						else
							Result := across 1 |..| (r1-r2).abs is a all (r1+a) = r2 or arrayboard[r1+a,c1+a] = 0 end
						end
					end
				elseif chess = 5 then
					if r1 = r2 then
						Result := across c1 |..| c2 is a all c1 = a or c2 = a or arrayboard[r1,a] =0 end
					elseif c1 = c2 then
						Result := across r1 |..| r2 is a all r1 = a or r2 = a or arrayboard[a,c1] =0 end
					end
				elseif chess = 6 then
					Result := True
				end

			end





	undomoveandcap(r1 : INTEGER;r2 : INTEGER;c1 : INTEGER;c2 : INTEGER;ch1 : INTEGER;ch2: INTEGER)
	require
		undo:
			undoredomode

		do
			arrayboard[r1,c1] := ch1
			arrayboard[r2,c2] := ch2
			chessnumber := chessnumber + 1
		end


feature -- return to etf
	getchessnumber : STRING
		do
			Result := chessnumber.out
		end

feature -- check lose
	checklose : BOOLEAN
		local
			stepmap : MOVE
			stepmaparray : ARRAY2[INTEGER_32]
		do
			Result := True
			create stepmap.make
			across 1 |..| 4 is x loop
			across 1 |..| 4 is y loop
				-- if we know the current location has a chess, we will do a possible move map for this chess
				if arrayboard[x,y] /= 0 then
					stepmap.make
					stepmap.makemovingmap (arrayboard[x,y], x, y)
					stepmaparray := stepmap.returnboard
					-- compare the possible move map and current map except the current location
					-- if we have a location which one of the chess able to move and there is a chess then return not lose(Flase)
					across 1 |..| 4 is a loop
					across 1 |..| 4 is b loop
						--
						if (a /= x or b /= y) and stepmaparray[a,b] = 9 and arrayboard[a,b] /= 0 then
							if notblock(x,y,a,b,stepmaparray) then
								Result := False
							end
						end
					end
					end
				end
			end
			end
		end


feature --redo undo

	redo
		local
			t : TUPLE[BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN]
	 	do

	 		undoredomode := True
	 		history.forth
	 		create {TUPLE[BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN]} t.default_create
			t.item (1) := game_started
			t.item (2) := gamelose
			t.item (3) := gamewon
			t.item (4) := error
			t.item (5) := gameover
	 		history.item.execute
	 		t := history.item.switch (t)
	 		game_started := t.boolean_item (1)
--	 		gamelose := t.boolean_item (2)
--	 		gamewon := t.boolean_item (3)
 		    error := t.boolean_item (4)
--	 		gameover := t.boolean_item (5)
	 		undoredomode := false
	 	end

	undo
		local
			t : TUPLE[BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN]
		do
	 		undoredomode := True
	 		create {TUPLE[BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN]} t.default_create
			t.item (1) := game_started
			t.item (2) := gamelose
			t.item (3) := gamewon
			t.item (4) := error
			t.item (5) := gameover
	 		history.item.undo
	 		t := history.item.switch (t)
	 		game_started := t.boolean_item (1)
	 		gamelose := t.boolean_item (2)
	 		gamewon := t.boolean_item (3)
	 		error := t.boolean_item (4)
	 		gameover := t.boolean_item(5)
	 		history.back
	 		undoredomode := false
		end

feature -- print
	out : STRING
		do
			Result := "  "
			if error then
				Result.append (errormessage)
				errormessage := ""
				error := False
			elseif gamewon then
				Result.append ("Game Over: You Win!"+ "%N")
				gamewon := False
				gameover := True
			elseif gamelose then
				Result.append ("Game Over: You Lose!"+ "%N")
				gamelose := False
				gameover := True
			elseif gameover then
				Result.append ("Error: Game already over"+ "%N")
			elseif game_started then
				Result.append ("Game In Progress..."+ "%N")
			else
				Result.append ("Game being Setup..." + "%N")
			end
			if movingmap.is_empty then
				Result.append (boardprintout)
			else
				Result.append (movingmap)
				movingmap.make_empty
			end
		end

	boardprintout : STRING
		do
			Result := "  "
				across 1 |..| 4 is x loop
				across 1 |..| 4 is y loop
					if
						arrayboard[x,y] = 0
					then
						Result := Result + "."
					elseif
						arrayboard[x,y] = 1
					then
						Result := Result + "K"
					elseif
						arrayboard[x,y] = 2
					then
						Result := Result + "Q"
					elseif
						arrayboard[x,y] = 3
					then
						Result := Result + "N"
					elseif
						arrayboard[x,y] = 4
					then
						Result := Result + "B"
					elseif
						arrayboard[x,y] = 5
					then
						Result := Result + "R"
					elseif
						arrayboard[x,y] = 6
					then
						Result := Result + "P"
					end
				end
					Result := Result + "%N  "
				end
				Result.remove_tail (3)
		end

end
