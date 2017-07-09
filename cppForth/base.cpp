#include "string.hpp"

uint32_t __forth_hash_string__(const char* str)
{
	uint32_t seed = 0;

	size_t s = Forth::String(str).size();
	for( size_t i = 0; i < s; ++i )
	{
		seed ^= str[i] + 0x9e3779b9 + (seed<<6) + (seed>>2);
	}

	return seed;
}

uint32_t __forth_reverse_hash_string__(const char* str)
{
	uint32_t seed = 0;

	size_t s = Forth::String(str).size();
	for( size_t i = 0; i < s; ++i )
	{
		seed ^= str[s - i - 1] + 0x9e3779b9 + (seed<<6) + (seed>>2);
	}

	return seed;
}
