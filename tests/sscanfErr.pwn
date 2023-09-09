#define SSCANF_NO_NICE_FEATURES

#include <a_samp>
#include <sscanf2>

ASSERT(bool:test, const message[])
{
	if (!test)
	{
		printf("SSCANF test failed: %s", message);
	}
}

main()
{
	ASSERT(SSCANF_GetErrorCategory(1004) == SSCANF_ERROR_MISSING, "SSCANF_ERROR_MISSING");
	ASSERT(SSCANF_GetErrorCategory(1009) == SSCANF_ERROR_EXCESS, "SSCANF_ERROR_EXCESS");
	ASSERT(SSCANF_GetErrorCategory(1001) == SSCANF_ERROR_COLOUR, "SSCANF_ERROR_COLOUR");
	ASSERT(SSCANF_GetErrorCategory(2) == SSCANF_ERROR_OVERFLOW, "SSCANF_ERROR_OVERFLOW");
	ASSERT(SSCANF_GetErrorCategory(1003) == SSCANF_ERROR_NOT_FOUND, "SSCANF_ERROR_NOT_FOUND");
	ASSERT(SSCANF_GetErrorCategory(1010) == SSCANF_ERROR_NO_ALTS, "SSCANF_ERROR_NO_ALTS");
	
	new str[8];
	ASSERT(sscanf("this-is-a-too-long-string", "s[8]", str) == 0);
	ASSERT(sscanf("this-is-a-too-long-string", "?<WARNINGS_AS_ERRORS=1>s[8]", str) == 2);
	ASSERT(sscanf("this-is-a-too-long-string", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CODE_IN_RET=1>s[8]", str) == 3 | (2 << 16));
	ASSERT(sscanf("this-is-a-too-long-string", "?<ERROR_CODE_IN_RET=1>s[8]", str) == 0);
	ASSERT(sscanf("this-is-a-too-long-string", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CATEGORY_ONLY=1>s[8]", str) == 3);
	ASSERT(sscanf("this-is-a-too-long-string", "?<ERROR_CATEGORY_ONLY=1>?<ERROR_CODE_IN_RET=1>s[8]", str) == 0);
	ASSERT(sscanf("this-is-a-too-long-string", "?<ERROR_CATEGORY_ONLY=1>?s[8]", str) == 0);
	ASSERT(sscanf("this-is-a-too-long-string", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CATEGORY_ONLY=1>?<ERROR_CODE_IN_RET=1>s[8]", str) == 4 | (7 << 16));
	
	new int;
	ASSERT(sscanf("not-a-number", "i", str) == 1);
	ASSERT(sscanf("not-a-number", "?<WARNINGS_AS_ERRORS=1>i", str) == 2);
	ASSERT(sscanf("not-a-number", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CODE_IN_RET=1>i", str) == 3 | (1011 << 16));
	ASSERT(sscanf("not-a-number", "?<ERROR_CODE_IN_RET=1>i", str) == 2 | (1011 << 16));
	ASSERT(sscanf("not-a-number", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CATEGORY_ONLY=1>i", str) == 3);
	ASSERT(sscanf("not-a-number", "?<ERROR_CATEGORY_ONLY=1>?<ERROR_CODE_IN_RET=1>i", str) == 3 | (3 << 16));
	ASSERT(sscanf("not-a-number", "?<ERROR_CATEGORY_ONLY=1>?i", str) == 2);
	ASSERT(sscanf("not-a-number", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CATEGORY_ONLY=1>?<ERROR_CODE_IN_RET=1>i", str) == 4 | (3 << 16));
}

