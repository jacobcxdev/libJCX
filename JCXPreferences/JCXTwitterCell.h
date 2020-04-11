#import "JCXLinkCell.h"

@interface JCXTwitterCell : JCXLinkCell {
    NSString *_Nullable _username;
}
+ (NSURL *_Nullable)twitterURLForUsername:(NSString *_Nonnull)username;
@end
