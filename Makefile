CC = g++

ifeq ($(OS),Windows_NT)
	# Windows build options here
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
		ifneq ($(wildcard /usr/include/SFML),)
			SFML_DIR_PREFIX = /usr
		else
			SFML_DIR_PREFIX = /usr/local
		endif
        CCFLAGS += -D LINUX
    endif
    # ifeq ($(UNAME_S),Darwin)
    #    CCFLAGS += -D OSX
    # endif
    # UNAME_P := $(shell uname -p)
    # ifeq ($(UNAME_P),x86_64)
    #    CCFLAGS += -D AMD64
    # endif
    # ifneq ($(filter %86,$(UNAME_P)),)
    #    CCFLAGS += -D IA32
    # endif
    # ifneq ($(filter arm%,$(UNAME_P)),)
    #    CCFLAGS += -D ARM
    # endif
endif

SFML_INCLUDE_DIR = $(SFML_DIR_PREFIX)/include/SFML

SFML_FLAGS = -lsfml-audio -lsfml-graphics -lsfml-window -lsfml-system
CFLAGS = $(SFML_FLAGS) -I$(SFML_INCLUDE_DIR) -Wall -O0 

.PHONY : all clean # Target that arent a file

all : SFML_Test clean

SRC = $(wildcard *.cpp)
OBJ = $(SRC:.cpp=.o) # Considera i file .cpp ma che che hanno come suffisso .o

SFML_Test : $(OBJ)
	@echo "** Building main program"
	$(CC) -o $@ $(OBJ) $(CFLAGS)

%.o: %.cpp
	@echo "** Building obj files..."
	$(CC) -c $< -o $@

clean :
	@echo "** Removing object files..."
	rm -f *.o
