#import "UIColor+HexString.h"

@implementation UIColor (HexString)
+ (instancetype _Nonnull)hexString:(NSString * _Nonnull)hexString {
    CGFloat r = 0, g = 0, b = 0, a = 1;
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    uint hexNumber = 0;
    if ([scanner scanHexInt:&hexNumber]) {
        if (hexString.length == 6) {
            r = ((CGFloat)((hexNumber & 0xff0000) >> 16)) / 255.0;
            g = ((CGFloat)((hexNumber & 0x00ff00) >> 8)) / 255.0;
            b = ((CGFloat)((hexNumber & 0x0000ff) >> 0)) / 255.0;
        }
        if (hexString.length == 8) {
            r = ((CGFloat)((hexNumber & 0xff000000) >> 16)) / 255.0;
            g = ((CGFloat)((hexNumber & 0x00ff0000) >> 8)) / 255.0;
            b = ((CGFloat)((hexNumber & 0x0000ff00) >> 0)) / 255.0;
            a = ((CGFloat)(hexNumber & 0x000000ff)) / 255.0;
        }
    }
    return [self colorWithRed:r green:g blue:b alpha:a];
}
+ (NSArray<UIColor *> * _Nonnull)arrayWithHexString:(NSString * _Nonnull)hexString {
    NSArray *hexArray = [[hexString stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","];
    NSMutableArray<UIColor *> *output = [NSMutableArray<UIColor *> new];
    for (NSString *hex in hexArray) {
        [output addObject:[self hexString:hex]];
    }
    return [output copy];
}
+ (NSArray<id> * _Nonnull)CGColorArrayWithHexString:(NSString * _Nonnull)hexString {
    NSArray *hexArray = [[hexString stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@","];
    NSMutableArray<id> *output = [NSMutableArray<id> new];
    for (NSString *hex in hexArray) {
        [output addObject:(id)[[self hexString:hex] CGColor]];
    }
    return [output copy];
}
@end
