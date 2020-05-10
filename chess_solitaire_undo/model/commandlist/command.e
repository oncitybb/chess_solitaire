note
	description: "Summary description for {COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMAND

feature
	model:ETF_MODEL
	modelaccess : ETF_MODEL_ACCESS
	t : TUPLE[BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN]
feature
	make
		do
			model := modelaccess.m
			create {TUPLE[BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN]} t.default_create
		end

feature
	execute
		deferred end
	undo
		deferred end

	switch(a: TUPLE[BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN]) : TUPLE[BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN]
    	local
    		temp : TUPLE[BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN,BOOLEAN]
    	do
    		temp := t
    		t := a
    		Result := temp
    	end

   	getstatus(one: BOOLEAN;two: BOOLEAN;three: BOOLEAN;four: BOOLEAN;five: BOOLEAN)
   		do
   			t.item (1) := one
			t.item (2) := two
			t.item (3) := three
			t.item (4) := four
			t.item (5) := five
   		end

   	returnmoveclass:BOOLEAN
   		do
   			Result := false
   		end
end
