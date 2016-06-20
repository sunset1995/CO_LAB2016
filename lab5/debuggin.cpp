#include <iostream>
#include <vector>
#include <stdio.h>
#include <math.h>
using namespace std;

struct cache_content{
	bool v;
	unsigned int  tag;
	cache_content()
	:v(false), tag(0) {}
};

const int K = 1024;

int log_2(int n) {
	int ret = -1;
	while( n ) {
		++ret;
		n >>= 1;
	}  
	return ret;
}


void simulate(int cache_size, int block_size) {
	unsigned int tag, index, x;

	int line       = cache_size/block_size;
	int index_bit  = log_2(line);
	int offset_bit = log_2(block_size);
	int index_mask = (1<<index_bit)-1;
	vector<cache_content> cache(line);

	printf("cache size: %d\n", cache_size);
	printf("block size: %d\n", block_size);
	printf("line      : %d\n", line);
	printf("n         : %d\n", index_bit);
	printf("offset bit: %d\n", offset_bit);
	
	FILE *fp=fopen("ICACHE.txt", "r");
	if( fp==NULL ) {
		perror("File not found.");
		return;
	}
	int addr, total=0, hit=0;
	while( fscanf(fp, "%x", &addr)!=EOF ) {
		int nodt  = addr>>offset_bit;
		int index = (addr>>offset_bit) & index_mask;
		int tag   = addr>>(index_bit + offset_bit);
		printf("addr %06x ; nodt %06x ; tag %3x ; index %3x ; %s\n", addr, nodt, tag, index, (cache[index].v==false)? "Miss(first)" : (cache[index].tag==tag? "Hit" : "Miss"));

		++total;
		if( cache[index].v && cache[index].tag==tag )
			++hit;
		else {
			cache[index].v   = true;
			cache[index].tag = tag;
		}
	}
	fclose(fp);
	
	printf("miss rate: %d/%d = %.2f%%\n", (total-hit), total, 100.0*(total-hit)/total);
}
	
int main() {
	// Let us simulate 4KB cache with 16B blocks
	simulate(64, 4);
}
