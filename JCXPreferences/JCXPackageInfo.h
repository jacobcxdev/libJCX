#import <Foundation/Foundation.h>
#import <NSTask.h>

@interface JCXPackageInfo : NSObject
+ (NSDictionary *_Nullable)controlForBundleID:(NSString *_Nullable)bundleID;
@end
