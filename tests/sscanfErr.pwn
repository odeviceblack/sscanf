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
	SSCANF_Option(SSCANF_QUIET, 1);	
	
	ASSERT(SSCANF_GetErrorCategory(1004) == SSCANF_ERROR_MISSING, "SSCANF_ERROR_MISSING");
	ASSERT(SSCANF_GetErrorCategory(1009) == SSCANF_ERROR_EXCESS, "SSCANF_ERROR_EXCESS");
	ASSERT(SSCANF_GetErrorCategory(1001) == SSCANF_ERROR_COLOUR, "SSCANF_ERROR_COLOUR");
	ASSERT(SSCANF_GetErrorCategory(2) == SSCANF_ERROR_OVERFLOW, "SSCANF_ERROR_OVERFLOW");
	ASSERT(SSCANF_GetErrorCategory(1003) == SSCANF_ERROR_NOT_FOUND, "SSCANF_ERROR_NOT_FOUND");
	ASSERT(SSCANF_GetErrorCategory(1010) == SSCANF_ERROR_NO_ALTS, "SSCANF_ERROR_NO_ALTS");
	
	new str[8];
	ASSERT(sscanf("this-is-a-too-long-string", "s[8]", str) == 0, "1");
	ASSERT(sscanf("this-is-a-too-long-string", "?<WARNINGS_AS_ERRORS=1>s[8]", str) == 2, "2");
	ASSERT(sscanf("this-is-a-too-long-string", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CODE_IN_RET=1>s[8]", str) == 3 | (2 << 16), "3");
	ASSERT(sscanf("this-is-a-too-long-string", "?<ERROR_CODE_IN_RET=1>s[8]", str) == 0, "4");
	ASSERT(sscanf("this-is-a-too-long-string", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CATEGORY_ONLY=1>s[8]", str) == 3, "5");
	ASSERT(sscanf("this-is-a-too-long-string", "?<ERROR_CATEGORY_ONLY=1>?<ERROR_CODE_IN_RET=1>s[8]", str) == 0, "6");
	ASSERT(sscanf("this-is-a-too-long-string", "?<ERROR_CATEGORY_ONLY=1>s[8]", str) == 0, "7a");
	ASSERT(sscanf("this-is-a-too-long-string", "?<ERROR_CATEGORY_ONLY=1>?s[8]", str) == 2, "7b");
	ASSERT(sscanf("this-is-a-too-long-string", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CATEGORY_ONLY=1>?<ERROR_CODE_IN_RET=1>s[8]", str) == 4 | (7 << 16), "8");
	
	new int;
	ASSERT(sscanf("not-a-number", "i", int) == 1, "9");
	ASSERT(sscanf("not-a-number", "?<WARNINGS_AS_ERRORS=1>i", int) == 2, "10");
	ASSERT(sscanf("not-a-number", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CODE_IN_RET=1>i", int) == 3 | (1011 << 16), "11");
	ASSERT(sscanf("not-a-number", "?<ERROR_CODE_IN_RET=1>i", int) == 2 | (1011 << 16), "12");
	ASSERT(sscanf("not-a-number", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CATEGORY_ONLY=1>i", int) == 3, "13");
	ASSERT(sscanf("not-a-number", "?<ERROR_CATEGORY_ONLY=1>?<ERROR_CODE_IN_RET=1>i", int) == 3 | (3 << 16), "14");
	ASSERT(sscanf("not-a-number", "?<ERROR_CATEGORY_ONLY=1>i", int) == 2, "15a");
	ASSERT(sscanf("not-a-number", "?<ERROR_CATEGORY_ONLY=1>?i", int) == 2, "15b");
	ASSERT(sscanf("not-a-number", "?<WARNINGS_AS_ERRORS=1>?<ERROR_CATEGORY_ONLY=1>?<ERROR_CODE_IN_RET=1>i", int) == 4 | (3 << 16), "18");
}

