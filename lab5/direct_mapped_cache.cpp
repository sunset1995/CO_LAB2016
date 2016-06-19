#include <iostream>
#include <vector>
#include <stdio.h>
#include <math.h>
using namespace std;

struct cache_content{
	bool v;
	unsigned int  tag;
};

const int K = 1024;

double log2(double n) {
	// log(n)/log(2) is log2.  
	return log(n) / log(2.0);  
}


void simulate(int cache_size, int block_size) {
	unsigned int tag, index, x;

	int offset_bit = (int)log2(block_size);
	int index_bit  = (int)log2(cache_size/block_size);
	int line       = (cache_size>>offset_bit);

	vector<cache_content> cache(line);
	printf("cache line:%d\n", line);

	for(int j=0; j<line; j++)
		cache[j].v = false;
	
	FILE * fp=fopen("ICACHE.txt", "r");
	if( fp==NULL ) {
		perror("File not found.");
		return;
	}

	unsigned int total=0, miss=0;
	while(fscanf(fp,"%x",&x)!=EOF) {
		++total;
		index = (x>>offset_bit)&(line-1);
		tag   = x>>(index_bit+offset_bit);
		if(cache[index].v && cache[index].tag==tag) {
			// hit
			cache[index].v=true;
		}
		else {
			// miss
			++miss;
			cache[index].v=true;
			cache[index].tag=tag;
		}
	}
	fclose(fp);
	printf("miss rate = %d/%d = %f%%\n", miss, total, 100.0*miss/total);
}
	
int main() {
	// Let us simulate 4KB cache with 16B blocks
	simulate(64, 32);
}
