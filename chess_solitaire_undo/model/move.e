note
	description: "Summary description for {MOVE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOVE

inherit
	ANY
		redefine
			out
		end

create
	make

feature
	movingchessboard : ARRAY2[INTEGER_32]

feature
	make
		do
			create movingchessboard.make_filled (0, 4, 4)

		end
--	K: INTEGER =1
--	Q: INTEGER =2
--	N: INTEGER =3
--	B: INTEGER =4
--	R: INTEGER =5
--	P: INTEGER =6
feature
	checkinboard(row,col:INTEGER): BOOLEAN
		do
			Result := True
			if row > 4 or row < 1 or col > 4 or col < 1 then
				Result := False
			end
		end


	huanqi(row,col:INTEGER)
		do
			if checkinboard(row,col) then
				movingchessboard[row,col] := 9
			end
		end

	cross(row,col,line:INTEGER)
		do
			huanqi(row+line,col+line)
			huanqi(row+line,col-line)
			huanqi(row-line,col+line)
			huanqi(row-line,col-line)
		end


	makemovingmap(chess,row,col:INTEGER)

		do
			if chess = 5 then
				across 1 |..| 4 is i loop
				 	huanqi(i,col)
				end
				across 1 |..| 4 is i loop
					huanqi(row,i)
				end
				movingchessboard[row,col] := chess
			elseif chess = 1 then
				across (row - 1) |..| (row + 1) is c loop
				across (col - 1) |..| (col + 1) is d loop
					huanqi(c,d)
				end
				end
				movingchessboard[row,col] := chess
			elseif chess = 2  then
				across 1 |..| 4 is i loop
				 	huanqi(i,col)
				end
				across 1 |..| 4 is i loop
					huanqi(row,i)
				end
				across (row - 1) |..| (row + 1) is i loop
				across (col - 1) |..| (col + 1) is j loop
					huanqi(i,j)
				end
				end
				across 1|..| 4 is i loop cross(row,col,i) end


				movingchessboard[row,col] := chess
			elseif chess = 3 then
				huanqi(row+2,col+1)
				huanqi(row+2,col-1)
				huanqi(row-2,col+1)
				huanqi(row-2,col-1)
				huanqi(row+1,col+2)
				huanqi(row+1,col-2)
				huanqi(row-1,col+2)
				huanqi(row-1,col-2)
				movingchessboard[row,col] := chess
			elseif chess = 4 then
				across 1 |..| 4 is i loop cross(row,col,i) end
				movingchessboard[row,col] := chess
			elseif chess = 6 then
				huanqi(row - 1, col + 1)
				huanqi(row - 1,col -1)
				movingchessboard[row,col] := chess
			end

		end

feature
	returnboard: ARRAY2[INTEGER_32]
		do
			Result := movingchessboard
		end


	out: STRING
		do
			Result := "  "
				across 1 |..| 4 is x loop
				across 1 |..| 4 is y loop
					if
						movingchessboard[x,y] = 0
					then
						Result := Result + "."
					elseif
						movingchessboard[x,y] = 1
					then
						Result := Result + "K"
					elseif
						movingchessboard[x,y] = 2
					then
						Result := Result + "Q"
					elseif
						movingchessboard[x,y] = 3
					then
						Result := Result + "N"
					elseif
						movingchessboard[x,y] = 4
					then
						Result := Result + "B"
					elseif
						movingchessboard[x,y] = 5
					then
						Result := Result + "R"
					elseif
						movingchessboard[x,y] = 6
					then
						Result := Result + "P"
					elseif
						movingchessboard[x,y] = 9
					then
						Result := Result + "+"
					end
				end
					Result := Result + "%N  "
				end
				Result.remove_tail (3)
		end
end
