//  FISAppDelegate.h

#import <UIKit/UIKit.h>

@interface FISAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)printWordsInAFrame:(NSArray *)wordsForTheFrame;
-(NSString *)addHeaderFooterWithSize:(NSUInteger)size;

@end
