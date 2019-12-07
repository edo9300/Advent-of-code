#include <iostream>
#include <stdlib.h>
#include <vector>

#define PART2

using namespace std;


class Box{
	public:
	int width, height, length;
	int surface();
	int smaller_area();
	int smaller_perimeter();
	int volume();
};

int Box::surface(){
	return 2*length*width + 2*width*height + 2*height*length;
}

int Box::smaller_area(){
	return (length*width*height)/max(max(length,width),height);
}

int Box::smaller_perimeter(){
	return 2 * (length + width + height - max(max(length,width),height));
}

int Box::volume(){
	return length*width*height;
}


int main(){
	FILE* fp=fopen("input 2.txt","r");
	char inputbuff[0x2000];
	char* strbuf;
	vector<Box> boxes;
	while(fgets(inputbuff,0x2000,fp)){
		Box box;
		char width[256], height[256], length[256];
		sscanf(inputbuff, "%dx%dx%d", &box.length, &box.width, &box.height);
		boxes.push_back(box);
	}
	fclose(fp);
	int total = 0;
	for(int i=0; i<boxes.size(); i++)
		#ifndef PART2
			total += boxes[i].surface()+boxes[i].smaller_area();
		#else
			total += boxes[i].smaller_perimeter() + boxes[i].volume();
		#endif
	cout<<total;
}
