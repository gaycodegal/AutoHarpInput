LUA=./lua-5.4.4
INC=-I$(LUA)/src/
SRC=$(LUA)/src/
OBJS_LIST=lapi.o lcode.o lctype.o ldebug.o ldo.o ldump.o lfunc.o lgc.o llex.o lmem.o lobject.o lopcodes.o lparser.o lstate.o lstring.o ltable.o ltm.o lundump.o lvm.o lzio.o
OBJS=$(patsubst %, $(SRC)%, $(OBJS_LIST))
CC=gcc
AR= ar rcu
RANLIB= ranlib
LINKER_FLAGS= 
LUA_A=lua.a
CFLAGS=

ifneq (,$(findstring wasm,$(MAKECMDGOALS)))
CC=emcc
#INC +=-Ifake-headers
CFLAGS += -O2
endif

CFLAGS += $(INC)


all: $(OBJS)
	echo $(OBJS)
#	$(CC)  $(CFLAGS) $(LINKER_FLAGS) -lm -o $(OBJ_NAME)
	$(AR) $(LUA_A) $(OBJS)
	$(RANLIB) $(LUA_A)
clean:
	git clean -fX
re:
	make clean all
format:
	clang-format -i $(shell find source/ headers/ term/ -iname '*.[ch]')

