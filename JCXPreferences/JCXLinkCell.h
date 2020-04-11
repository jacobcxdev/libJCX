#import "JCXTableCell.h"

@interface JCXLinkCell : JCXTableCell {
    NSURL *_Nullable _avatarURL;
    UIView *_Nullable _avatarView;
    UIImageView *_Nullable _avatarImageView;
    UIImage *_Nullable _avatar;
    NSString *_Nullable _avatarImageSystemName;
    NSString *_Nullable _accessoryImageSystemName;
    NSURL *_Nonnull _linkURL;
    bool _shouldDisplayAvatar;
}
- (void)loadAvatarIfNeeded;
- (void)setAvatar:(UIImage *_Nonnull)image;
- (void)setAvatarHidden:(bool)hidden;
- (void)setLinkURL:(NSURL *_Nonnull)url;
@end
