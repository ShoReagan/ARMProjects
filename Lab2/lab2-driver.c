/* CSE 2312 - Spring 2022 - Lab 2 Driver
 *
 * Programming Lab Policies:
 *  - Labs that fail to compile, or do not terminate correctly, will receive a zero.
 *  - Labs that fail to compile, or do not terminate correctly, may not be resubmitted for a grade.   
 *      This includes instances where students did not upload the correct file for grading.
 *  - All labs must be submitted via the upload link on Canvas.  Labs are not accepted through 
 *      e-mail or Canvas Messenger.
 *  - Students must make a credible attempt to pass all programming labs to receive a passing
 *      grade in the course.
 *
 * All values are example values only - student programs will be evaluated with 
 * different inputs.  Students are expected to test their code with different 
 * values to ensure their code functions correctly.
 *
 */
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>

extern void stringCopy(char* strTo, char* strFrom); // copies strFrom to strTo
extern void stringCat(char* strFrom, char* strTo); // adds strFrom to end of strTo
extern int8_t sumS8(int8_t x[], int32_t count);
extern int16_t sumS16(int16_t x[], int32_t count);
extern uint64_t sumU32_64(uint32_t x[], uint32_t count);
extern uint32_t countNegative (int16_t x[], uint32_t count);
extern uint32_t countNonNegative (int8_t x[], uint32_t count);
extern uint32_t countMatches(char str[], char toMatch);
extern int16_t returnMax(int16_t x[], uint32_t count);
extern int16_t returnMin(int16_t x[], uint32_t count);

#define COUNT 5

int main(void) {
	
	int16_t arrayInt16[COUNT] = {129, 256, 512, 1024, 2048};
	int8_t arrayInt8[COUNT] = {-4, -5, 6, 7, 8};
	
	uint32_t arrayUint32[COUNT] = {4000000001, 4000000001, 4000000001, 4000000001, 4000000001};
	
	char test1[20] = "aaaaaaa";
	char test2[44] = "bbbbbbb";

	stringCopy(test1, test2);
	
	printf("Question 1, stringCopy: Correct answer = bbbbbbb\n");
	printf("Question 1, stringCopy: Student answer = %s\n\n", test1);

	char test3[20] = "aaaaaaa";
	char test4[44] = "bbbbbbb"; 

	stringCat(test3, test4);	

	printf("Question 2, stringCat: Correct answer = bbbbbbbaaaaaaa\n");
	printf("Question 2, stringCat: Student answer = %s\n\n", test4);	

	printf("Question 3, sumS8: Correct answer = 12\n");
	printf("Question 3, sumS8: Student answer = %hhd\n\n", sumS8(arrayInt8, COUNT));
	
	printf("Question 4, sumS16: Correct answer = 3969\n");
	printf("Question 4, sumS16: Student answer = %hd\n\n", sumS16(arrayInt16, COUNT));
	
	printf("Question 5, sumU32_64: Correct answer = 20000000005\n");
	printf("Question 5, sumU32_64: Student answer = %lld\n\n", sumU32_64(arrayUint32, COUNT));
	
	arrayInt16[2] = 0;
	arrayInt16[3] = -1;
	arrayInt16[4] = -2047;
	
	printf("Question 6, countNegative: Correct answer = 2\n");
	printf("Question 6, countNegative: Student answer = %u\n\n", countNegative(arrayInt16, COUNT));
	
	printf("Question 7, countNonNegative: Correct answer = 3\n");
	printf("Question 7, countNonNegative: Student answer = %u\n\n", countNonNegative(arrayInt8, COUNT));
	
	char str[] = "aabbccddeeffgghhiijjkkllmmnnooppqqrrss";
	
	printf("Question 8, countMatches: Correct Answer = 2\n");
	printf("Question 8, countMatches: Student Answer = %u\n\n", countMatches(str, 'g'));
	
	printf("Question 9, returnMax: Correct Answer = 256\n");
	printf("Question 9, returnMax: Student Answer = %hd\n\n", returnMax(arrayInt16, COUNT));
	
	printf("Question 10, returnMin: Correct Answer = -2047\n");
	printf("Question 10, returnMin: Student Answer = %hd\n\n", returnMin(arrayInt16, COUNT));
	
	return EXIT_SUCCESS;
}
