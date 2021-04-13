
#include <fstream>

void do_stuff(){
	std::ofstream f("out_file.txt", std::ios::binary);

	f << "Hello world!";
}
