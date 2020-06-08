#import "NSAttributedString+JCX.h"

@implementation NSAttributedString (JCX)
+ (instancetype)stringWithFormat:(NSString *)format, ... {
    va_list arguments;
    va_start(arguments, format);

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:format];
    scanner.charactersToBeSkipped = [NSCharacterSet new];
    while (![scanner isAtEnd]) {
        NSString *discarded;
        [scanner scanUpToString:@"%" intoString:&discarded];
        if (discarded) {
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:discarded]];
        }
        if ([scanner scanString:@"%%" intoString:NULL]) {
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"%"]];
        } else if ([scanner scanString:@"%@" intoString:NULL]) {
            id object = va_arg(arguments, id);
            if(![object isKindOfClass:NSAttributedString.class]) {
                object = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", object]];
            }
            [attributedString appendAttributedString:object];
        } else if ([scanner scanString:@"%" intoString:NULL]) {
            NSString *specifier = [format substringFromIndex:scanner.scanLocation];
            if(specifier.length > 1) {
                specifier = [specifier substringToIndex:1];
            }
            NSAssert(false, @"Unsupported format specifier '%@'", specifier);
        }
    }
    return attributedString;
}
@end

