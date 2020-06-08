#import <UIKit/UIKit.h>

@interface UIColor (HexString)
+ (instancetype _Nonnull)hexString:(NSString * _Nonnull)hexString;
+ (NSArray<UIColor *> * _Nonnull)arrayWithHexString:(NSString * _Nonnull)hexString;
+ (NSArray<id> * _Nonnull)CGColorArrayWithHexString:(NSString * _Nonnull)hexString;
@end
