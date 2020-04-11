#import "JCXGradientHeaderCellBlurContentView.h"

@interface JCXGradientHeaderCell : JCXTableCell {
    UIImage *_Nullable _icon;
    UIImageView *_Nullable _iconView;
    UILabel *_Nonnull _label;
    UILabel *_Nonnull _detailLabel;
    JCXGradientHeaderCellBlurContentView *_Nonnull _blurContentView;
    CAGradientLayer *_Nonnull _gradientLayer;
    UIVisualEffectView *_Nonnull _blurView;
    bool _animated;
}
- (void)addAnimation;
@end
