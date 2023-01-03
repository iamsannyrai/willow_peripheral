all: dart_proto

dart_proto: *.proto
	@protoc --dart_out=../ -I . *.proto
