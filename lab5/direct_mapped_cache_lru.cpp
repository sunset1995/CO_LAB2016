// 0317001_0310511
#include <iostream>
#include <vector>
#include <stdio.h>
#include <math.h>
#define FILENAME "RADIX.txt"
using namespace std;

struct cache_content{
	unsigned int timestamp, tag;
	cache_content()
	:timestamp(0u), tag(0u) {}
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

int bitRequired(int cache_size, int block_size, int associate) {
	int line      = cache_size / block_size / associate;
	int tagBitNum = 32 - (log2(block_size)+log2(line));
	return line * associate * (1 + tagBitNum + block_size*8) / K;
}

void simulate(int cache_size, int block_size, int associate) {
	unsigned int tag, index, x;

	int offset_bit = log2(block_size);
	int index_bit  = log2(cache_size/block_size/associate);
	int line       = (cache_size>>offset_bit) / associate;
	unsigned int index_mask = line - 1;

	vector<cache_content>           initLine(associate);
	vector< vector<cache_content> > cache(line, initLine);
	
	FILE * fp=fopen(FILENAME, "r");
	if( fp==NULL ) {
		perror("File not found.");
		return;
	}

	unsigned int total=0, miss=0;
	while(fscanf(fp,"%x",&x)!=EOF) {
		++total;
		unsigned nodt = x>>offset_bit;
		index = nodt & index_mask;
		tag   = nodt >> index_bit;
		
		int lruID = 0;
		for(int i=0; i<associate; ++i)
			if( cache[index][i].tag==tag ) {
				lruID = i;
				break;	
			}
			else if( cache[index][i].timestamp < cache[index][lruID].timestamp )
				lruID = i;
		if( cache[index][lruID].tag != tag )
			++miss;
		cache[index][lruID].timestamp = total;
		cache[index][lruID].tag       = tag;
	}
	fclose(fp);
	printf("%6.2f%%", 100.0*miss/total);
}
	
int main() {
	// Let us simulate 4KB cache with 16B blocks
	int startAssocia = 1;
	int startCacheSz = 1*K;
	int associate, cacheSz;

	cacheSz = startCacheSz;
	puts("Miss rate");
	printf("     ");
	for(int i=1; i<=8; i*=2)
		printf("%7d", i);
	puts("");
	for(int i=0; i<6; ++i) {
		printf("%4dK", cacheSz / K);
		associate = startAssocia;
		for(int j=0; j<4; ++j) {
			simulate(cacheSz, 64, associate);
			associate *= 2;
		}
		cacheSz *= 2;
		puts("");
	}


	cacheSz = startCacheSz;
	puts("Bits required");
	printf("     ");
	for(int i=1; i<=8; i*=2)
		printf("%7d", i);
	puts("");
	for(int i=0; i<6; ++i) {
		printf("%4dK", cacheSz / K);
		associate = startAssocia;
		for(int j=0; j<4; ++j) {
			printf("%7d", bitRequired(cacheSz, 64, associate));
			associate *= 2;
		}
		cacheSz *= 2;
		puts("");
	}
	return 0;
}
