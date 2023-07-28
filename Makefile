CC = gcc
CFLAGS = -Wall -Wextra

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

$(shell mkdir -p $(OBJ_DIR) $(BIN_DIR))

SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC_FILES))

all: $(BIN_DIR)/main

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN_DIR)/const: $(OBJ_DIR)/const.o
	$(CC) $(CFLAGS) $< -o $@

$(SRC_DIR)/file_flags.S: $(BIN_DIR)/const
	$(BIN_DIR)/const > $@

$(OBJ_DIR)/main.o: $(SRC_DIR)/file_flags.S

$(BIN_DIR)/main: $(OBJ_DIR)/main.o
	$(CC) $(CFLAGS) -nostartfiles -static $< -o $@

clean:
	$(RM) -vf $(BIN_DIR)/main $(OBJ_FILES) $(BIN_DIR)/const $(SRC_DIR)/file_flags.S
