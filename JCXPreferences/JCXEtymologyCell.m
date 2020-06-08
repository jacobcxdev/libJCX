#import "JCXEtymologyCell.h"
#import "NSAttributedString+JCX.h"

@implementation JCXEtymologyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    if (!specifier.properties[@"accessoryImageSystemName"]) {
        specifier.properties[@"accessoryImageSystemName"] = @"book.fill";
    }
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
    if (self) {
        if (@available(iOS 13, *)) self.tintColor = [UIColor labelColor];
        else self.tintColor = [UIColor whiteColor];
        self.textLabel.numberOfLines = 0;

        NSDictionary *control = [JCXPackageInfo controlForBundleID:specifier.properties[@"tweakBundle"]];
        NSString *word = [specifier.properties[@"word"] stringByInterpolatingPackageInfoFromControl:control];
        NSString *information = [specifier.properties[@"information"] stringByInterpolatingPackageInfoFromControl:control];
        NSString *definition = [specifier.properties[@"definition"] stringByInterpolatingPackageInfoFromControl:control];
        NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
        NSAttributedString *strikethroughString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\U000000A0%C\U000000A0\n", 0x00000009] attributes:@{
            NSStrikethroughColorAttributeName: [UIColor separatorColor],
            NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)
        }];
        if (word) {
            _wordAttributedString = [[NSAttributedString alloc] initWithString:word attributes:@{
                NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]
            }];
            [attributedString appendAttributedString:_wordAttributedString];
        }
        if (information) {
            UIFontDescriptor *fontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleCaption1];
            fontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];
            if (@available(iOS 13, *)) {
                _informationAttributedString = [[NSAttributedString alloc] initWithString:information attributes:@{
                    NSFontAttributeName: [UIFont fontWithDescriptor:fontDescriptor size:0]
                }];
            } else {
                _informationAttributedString = [[NSAttributedString alloc] initWithString:information attributes:@{
                    NSFontAttributeName: [UIFont fontWithDescriptor:fontDescriptor size:0]
                }];
            }
            attributedString = [NSMutableAttributedString stringWithFormat:@"%@%@%@", attributedString, attributedString.mutableString.length > 0 ? @"\n" : @"", _informationAttributedString];
        }
        if (definition) {
            if (@available(iOS 13, *)) {
                _definitionAttributedString = [[NSAttributedString alloc] initWithString:definition attributes:@{
                    NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]
                }];
            } else {
                _definitionAttributedString = [[NSAttributedString alloc] initWithString:definition attributes:@{
                    NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]
                }];
            }
            attributedString = [NSMutableAttributedString stringWithFormat:@"%@%@%@", attributedString, attributedString.mutableString.length > 0 ? strikethroughString : @"", _definitionAttributedString];
        }
        self.textLabel.attributedText = attributedString;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (@available(iOS 13, *)) self.backgroundColor = [UIColor secondarySystemBackgroundColor];
    else self.backgroundColor = [UIColor whiteColor];
}
@end