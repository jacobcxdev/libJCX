#import "JCXLinkCell.h"

@interface JCXPayPalCell : JCXLinkCell {
    NSString *_Nullable _username;
}
+ (NSURL *_Nullable)paypalURLForUsername:(NSString *_Nonnull)username;
@end
