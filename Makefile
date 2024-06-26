CMAKE=cmake
BUILD_TYPE=Debug
BUILD_DIR=build
BIN_DIR:=$(BUILD_DIR)/$(BUILD_TYPE)
TARGET=gpol
MESH=socket.1
OUT=test.off

.PHONY: all clean build run autoload

init:
	@mkdir -p $(BUILD_DIR)/
	$(CMAKE) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -B $(BIN_DIR)/ .
	@cp $(BIN_DIR)/compile_commands.json .

build:
	$(CMAKE) --build $(BIN_DIR) -j 10

run: build
	./$(BIN_DIR)/$(TARGET) data/$(MESH) $(OUT)

clean:
	rm -rf $(BUILD_DIR)

autoload: 
	find src/ | entr -s "make build"
