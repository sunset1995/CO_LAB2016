#include <iostream>
#include <vector>
#include <stdio.h>
#include <math.h>
#define FILENAME "ICACHE.txt"
using namespace std;

struct cache_content{
	bool v;
	unsigned int  tag;
};

const int K = 1024;

int log2(int n) {
	// log(n)/log(2) is log2.  
	int ret = -1;
	while( n ) {
		++ret;
		n >>= 1;
	}  
	return ret;
}


void simulate(int cache_size, int block_size) {
	unsigned int tag, index, x;

	int offset_bit = log2(block_size);
	int index_bit  = log2(cache_size/block_size);
	int line       = (cache_size>>offset_bit);

	vector<cache_content> cache(line);

	for(int j=0; j<line; j++)
		cache[j].v = false;
	
	FILE * fp=fopen(FILENAME, "r");
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
	printf("%6.2f%%", 100.0*miss/total);
}
	
int main() {
	// Let us simulate 4KB cache with 16B blocks
	int startBlockSz = 2;
	int startCacheSz = 64;
	int blockSz, cacheSz;

	cacheSz = startCacheSz;
	puts("line");
	printf("    ");
	for(int i=2; i<=32; i*=2)
		printf("%7d", i);
	puts("");
	for(int i=0; i<4; ++i) {
		printf("%4d", cacheSz);
		blockSz = startBlockSz;
		for(int j=0; j<5; ++j) {
			printf("%7d", cacheSz/blockSz);
			blockSz *= 2;
		}
		cacheSz *= 2;
		puts("");
	}
	puts("");

	cacheSz = startCacheSz;
	puts("Miss rate");
	printf("    ");
	for(int i=2; i<=32; i*=2)
		printf("%7d", i);
	puts("");
	for(int i=0; i<4; ++i) {
		printf("%4d", cacheSz);
		blockSz = startBlockSz;
		for(int j=0; j<5; ++j) {
			simulate(cacheSz, blockSz);
			blockSz *= 2;
		}
		cacheSz *= 2;
		puts("");
	}
}
