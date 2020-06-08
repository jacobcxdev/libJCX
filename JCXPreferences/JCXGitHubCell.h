#import "JCXLinkCell.h"

@interface JCXGitHubCell : JCXLinkCell {
    NSString * _Nullable _remote;
}
+ (NSURL * _Nullable)gitHubURLForRemote:(NSString * _Nonnull)remote;
@end
