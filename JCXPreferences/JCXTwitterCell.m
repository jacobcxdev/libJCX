#import "JCXTwitterCell.h"

@implementation JCXTwitterCell
+ (NSURL * _Nullable)twitterURLForUsername:(NSString * _Nonnull)username {
    username = [username stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"aphelion://"]]) {
        return [NSURL URLWithString:[@"aphelion://profile/" stringByAppendingString:username]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]]) {
        return [NSURL URLWithString:[@"tweetbot:///username_profile/" stringByAppendingString:username]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific://"]]) {
        return [NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:username]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings://"]]) {
        return [NSURL URLWithString:[@"tweetings:///username?screen_name=" stringByAppendingString:username]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
        return [NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:username]];
    } else {
        return [NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:username]];
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    if (!specifier.properties[@"avatarImageSystemName"]) {
        specifier.properties[@"avatarImageSystemName"] = @"person.crop.circle.fill";
    }
    if (!specifier.properties[@"accessoryImageSystemName"]) {
        specifier.properties[@"accessoryImageSystemName"] = @"person.crop.circle.badge.plus";
    }
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
    if (self) {
        _username = specifier.properties[@"username"];
        if (!_username) return self;
        self.detailTextLabel.text = [@"@" stringByAppendingString:_username];
        _avatarURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://mobile.twitter.com/%@/profile_image?size=original", _username]];
        _linkURL = [[self class] twitterURLForUsername:_username];
        [self setCellEnabled:true];
        [self loadAvatarIfNeeded];
    }
    return self;
}
- (void)loadAvatarIfNeeded {
    if (_avatar) return;
    if (!_avatarURL) return;
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_avatarURL];
		[request setValue:@"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" forHTTPHeaderField:@"User-Agent"];
		NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!data) return;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setAvatar:[UIImage imageWithData:data]];
                [self setAvatarHidden:false];
            });
        }];
        [dataTask resume];
    });
}
@end
