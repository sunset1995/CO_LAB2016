#include <iostream>
#include <vector>
#include <stdio.h>
#include <math.h>
#define FILENAME "RADIX.txt"
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


void simulate(int cache_size, int block_size, int associate) {
	unsigned int tag, index, x;

	int offset_bit = log2(block_size);
	int index_bit  = log2(cache_size/block_size/associate);
	int line       = (cache_size>>offset_bit) / associate;

	vector<int>           initTimestamp(associate, 0);
	vector< vector<int> > timestamp(line, initTimestamp);
	vector<cache_content>           initLine(associate);
	vector< vector<cache_content> > cache(line, initLine);

	for(int j=0; j<line; j++)
	for(int k=0; k<associate; ++k)
		cache[j][k].v = false;
	
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
		bool hit = false;
		for(int i=0; i<associate; ++i)
			if(cache[index][i].v && cache[index][i].tag==tag)
				hit = true;
		if( hit ) continue;
		++miss;
		int lruID = 0;
		for(int i=0; i<associate; ++i)
			if(cache[index][i].v==false) {
				lruID = i;
				break;	
			}
			else if(timestamp[index][i] < timestamp[index][lruID])
				lruID = i;
		cache[index][lruID].v   = true;
		cache[index][lruID].tag = tag;
		timestamp[index][lruID] = total;
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
		printf("%5d", cacheSz);
		associate = startAssocia;
		for(int j=0; j<4; ++j) {
			simulate(cacheSz, 64, associate);
			associate *= 2;
		}
		cacheSz *= 2;
		puts("");
	}
}
