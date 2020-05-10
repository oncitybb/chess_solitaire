note
	description: "Summary description for {HISTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY

create
	make

feature
	make
		do
			create arraylist.make_empty
			index := 0
		end

feature
	arraylist : ARRAY[COMMAND]
	index : INTEGER

feature -- basic function


	add(comman : COMMAND)

		do
			arraylist.remove_tail (arraylist.count - index)
			index := arraylist.count + 1
			arraylist.force (comman, arraylist.count + 1)
		end




	is_empty : BOOLEAN
		do
			Result := index = 0 or arraylist.count = 0 or arraylist.is_empty
		end

	after: BOOLEAN
		do
			Result := index >= arraylist.count
		end
	before : BOOLEAN
		do
			Result := index < 1

		end

	item: COMMAND
		require
			indexoutbound:
				index > 0 or index <= arraylist.count
		do
			Result := arraylist[index]
		end

	forth
		require
			notafter:
				index <= arraylist.count
		do
			index := index + 1
		end

	back
		require
			notfront:
				index >= 1
		do
			index := index - 1
		end
end
