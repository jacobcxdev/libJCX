#import "JCXPackageInfo.h"

@implementation JCXPackageInfo
static NSMutableDictionary<NSString *, NSDictionary *> *_controlDict;
+ (NSDictionary *_Nullable)controlForBundleID:(NSString *_Nullable)bundleID {
    if (!bundleID) return nil;
    if (!_controlDict) _controlDict = [NSMutableDictionary<NSString *, NSDictionary *> new];
    if (!_controlDict[bundleID]) {
        NSTask *dpkg = [NSTask new];
        [dpkg setLaunchPath:@"/usr/bin/dpkg"];
        [dpkg setArguments:@[@"-s", bundleID]];
        NSPipe *dpkgPipe= [NSPipe pipe];
        [dpkg setStandardOutput:dpkgPipe];
        NSFileHandle *outputFile = [dpkgPipe fileHandleForReading];
        [dpkg launch];
        [dpkg waitUntilExit];
        
        NSData *data = [outputFile readDataToEndOfFile];
        NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<fieldName>[^:\\r\\n]+):[^\\S\\r\\n]*(?<fieldContent>.*?)(?:<[^<>\\r\\n]+>|$)" options:NSRegularExpressionAnchorsMatchLines error:&error];
        if (!error) {
            NSArray *matches = [regex matchesInString:output options:0 range:NSMakeRange(0, output.length)];
            NSMutableDictionary *control = [NSMutableDictionary new];
            for (NSTextCheckingResult *match in matches) {
                NSString *substring = [[output substringWithRange:[match rangeWithName:@"fieldContent"]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                control[[output substringWithRange:[match rangeWithName:@"fieldName"]]] = substring;
            }
            _controlDict[bundleID] = [control copy];
        }
    }
    return _controlDict[bundleID];
}
@end
