#import "JCXDisclosureCell.h"

@implementation JCXDisclosureCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
    if (self) {
        if (@available(iOS 13.0, *)) self.tintColor = UIColor.labelColor;
        else self.tintColor = UIColor.whiteColor;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}
@end
