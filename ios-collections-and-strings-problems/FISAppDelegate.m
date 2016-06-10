//  FISAppDelegate.m

#import "FISAppDelegate.h"


@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //calling the methods
    NSArray *wordArray = @[@"Michael", @"Knight", @"had", @"a", @"very", @"cool", @"car"] ;
    [self printWordsInAFrame:wordArray];
    [self logThePigLatinVersionOf:@"The quick brown fox"];
    
    NSArray *array1 = @[@1, @"hello"];
    NSArray *array2 = @[@2, @"hi"];
    [self alternateTheLists:array1 withThelist:array2];
    
    
    NSLog(@"%@",[self ArrayOfDigitsByNumber:45846509890]);
    
    NSLog(@"%@",[self reverseArrayInPlaceWithArray:@[@(6),@(5),@(4),@(3),@(2),@(1)]]);
    
    return YES;
}
///// METHODS ////////

//reversing an array in place - without a second array
-(NSArray *)reverseArrayInPlaceWithArray:(NSArray *)arrayToReverse {
    NSMutableArray *reversedArray = [arrayToReverse mutableCopy];
    NSUInteger arraySize = [reversedArray count];
    
    for (NSUInteger i=0; i<arraySize/2; i++) {
        id object = reversedArray[i];
        reversedArray[i]=reversedArray[arraySize-1-i];
        reversedArray[arraySize-1-i]=object;
    }
    
    //another way to do
    for (NSUInteger i=0; i < arraySize/2; i++) {
        [reversedArray exchangeObjectAtIndex:i withObjectAtIndex:arraySize-1-i];
    }
    
    return reversedArray;
}

//returning an array of digits of a number
-(NSArray *)ArrayOfDigitsByNumber:(NSUInteger)number {
    NSString *stringOfNumber = [NSString stringWithFormat:@"%lu",number];
    NSMutableArray *digitsOfTheNumber = [[NSMutableArray alloc] init];
    
    for (NSUInteger i=0; i < [stringOfNumber length]; i++) {
        [digitsOfTheNumber addObject:[NSString stringWithFormat:@"%c", [stringOfNumber characterAtIndex:i]]];
        digitsOfTheNumber[i] = @([digitsOfTheNumber[i] integerValue]);
    }
        return digitsOfTheNumber;
}

//alternating lists
-(void)alternateTheLists:(NSArray *)firstList
             withThelist:(NSArray *)secondList
{
    NSMutableArray *finalList = [[NSMutableArray alloc] init];
    NSUInteger smallerListSize = [firstList count] < [secondList count] ? [firstList count] : [secondList count];
    
    for (NSUInteger i = 0; i < smallerListSize; i++) {
        [finalList addObject:firstList[i]];
        [finalList addObject:secondList[i]];
    }
    for (NSUInteger i=0; i<[finalList count]; i++) {
        if ([finalList[i] isKindOfClass:[NSNumber class]]) {
            finalList[i] = [finalList[i] stringValue];
        }
        if ([finalList[i] isKindOfClass:[NSString class]]) {
            NSLog(@"yes it is a string");
        }
    }
    NSLog(@"%@",finalList);
}



//pig latin section
-(void)logThePigLatinVersionOf:(NSString *)sentence {
    NSArray *ay = @[@"a",@"y"];
    NSArray *words = [sentence componentsSeparatedByString:@" "];
    NSLog(@"words separated: %@", words);
    NSString *finalWord = @"";
    
    for (NSUInteger wordIndex = 0; wordIndex < [words count]; wordIndex++) {
        NSMutableString *tempWord = words[wordIndex];
        NSMutableArray *letters = [[NSMutableArray alloc] initWithCapacity:[tempWord length]];
        for (NSUInteger i = 0; i < [tempWord length]; i++) {
            [letters addObject:[NSString stringWithFormat:@"%c",[tempWord characterAtIndex:i]]];
        }
        NSString *firstLetter = [letters[0] lowercaseString];
        for (NSUInteger i=0; i<[letters count]-1; i++) {
            [letters replaceObjectAtIndex:i withObject:letters[i+1]];
        }
        [letters replaceObjectAtIndex:[letters count]-1 withObject:firstLetter];
        if (wordIndex == 0) {
            letters[0]=[letters[0] capitalizedString];
        }
        [letters addObjectsFromArray:ay];
        
        for (NSUInteger i=0; i< [letters count]; i++) {
            finalWord = [finalWord stringByAppendingString:letters[i]];
        }
        if (wordIndex != [words count]-1) {
            finalWord = [finalWord stringByAppendingString:@" "];
        }
    }
        NSLog(@"%@",finalWord);
}



//printing words in a frame
-(void)printWordsInAFrame:(NSArray *)wordsForTheFrame {
    NSString *frameWithWords = @"";
    
    NSUInteger maxLength = 0;
    for (NSString *word in wordsForTheFrame) {
        if ([word length] > maxLength) {
            maxLength = [@"* " length] + [word length] + [@" *" length];
        }
    }
    //add the header
    frameWithWords = [frameWithWords stringByAppendingFormat:@"%@\n",[self addHeaderFooterWithSize:maxLength]];
    
    //add the words
    for (NSUInteger i=0; i<[wordsForTheFrame count]; i++) {
        frameWithWords = [frameWithWords stringByAppendingFormat:@"* "];
        frameWithWords = [frameWithWords stringByAppendingFormat:@"%@",wordsForTheFrame[i]];
        NSUInteger j = [wordsForTheFrame[i] length]+[@"* *" length];
        while (j < maxLength) {
            frameWithWords = [frameWithWords stringByAppendingFormat:@" "];
            j++;
        }
        frameWithWords = [frameWithWords stringByAppendingFormat:@"*\n"];
    }
    
    //add the footer
    frameWithWords = [frameWithWords stringByAppendingString:[self addHeaderFooterWithSize:maxLength]];
    
    NSLog(@"here is our frame:\n%@", frameWithWords);
}

-(NSString *)addHeaderFooterWithSize:(NSUInteger)size {
    NSString *headerOrFooter = @"";
    for (NSUInteger i=0; i<size; i++) {
        headerOrFooter = [headerOrFooter stringByAppendingFormat:@"*"];
    }
    return headerOrFooter;
} // end of printing words in a frame section






@end
