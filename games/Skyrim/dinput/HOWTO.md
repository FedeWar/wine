Skyrim has issues with the mouse clipping management of dinput.dll, to fix it you have two ways:

1) Download mouse.c and overwrite dlls/dinput/mouse.c (you need to clone the Wine repo), then configure, compile and copy the result.
	
	./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32" # It has to be 32-bit
	cd dlls/dinput
	make all
	sudo mv dinput.dll.so /usr/lib/wine

Now open wine and set dinput = builtin

2) Download dinput.dll.so and copy it in /usr/lib/wine (overwrite the old one), set dinput = builtin
