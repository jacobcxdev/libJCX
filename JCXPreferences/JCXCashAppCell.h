#import "JCXLinkCell.h"

@interface JCXCashAppCell : JCXLinkCell {
    NSString * _Nullable _cashTag;
}
+ (NSURL * _Nullable)cashAppURLForUsername:(NSString * _Nonnull)cashTag;
@end
