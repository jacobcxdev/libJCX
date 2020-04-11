#import "JCXLinkCell.h"

@interface JCXMailCell : JCXLinkCell {
    NSString *_Nullable _emailAddress;
}
+ (NSURL *_Nullable)mailtoURLWithEmailAddress:(NSString *_Nonnull)emailAddress;
@end
