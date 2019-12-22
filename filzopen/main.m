//
//  main.m
//  filzopen
//
//  Created by Leptos on 12/22/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

#import <Foundation/Foundation.h>

API_AVAILABLE(ios(5.0))
@interface LSApplicationWorkspace : NSObject
+ (instancetype)defaultWorkspace;
- (BOOL)openURL:(NSURL *)url API_AVAILABLE(ios(6.0));
@end

int main(int argc, char *argv[]) {
    const char *argOne = argv[1];
    if (!argOne) {
        printf("Usage: %s <path>\n", argv[0]);
        return 1;
    }
    
    NSFileManager *fileManager = NSFileManager.defaultManager;
    NSString *target = @(argOne);
    
    if (!target.absolutePath) {
        target = [fileManager.currentDirectoryPath stringByAppendingPathComponent:target];
    }
    
    target = target.stringByStandardizingPath;
    
    BOOL isDir = NO;
    if (![fileManager fileExistsAtPath:target isDirectory:&isDir]) {
        errno = ENOENT;
        perror(target.fileSystemRepresentation);
        return EXIT_FAILURE;
    }
    if (isDir) {
        target = [target stringByAppendingPathComponent:@"."];
    }
    
    NSURLComponents *urlComps = [NSURLComponents new];
    urlComps.scheme = @"filza";
    urlComps.host = @"";
    urlComps.path = target;
    return [LSApplicationWorkspace.defaultWorkspace openURL:urlComps.URL] ? EXIT_SUCCESS : EXIT_FAILURE;
}
