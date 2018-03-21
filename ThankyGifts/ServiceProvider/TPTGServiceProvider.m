//
//  TPTGServiceProvider.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/20/18.
//

#import "TPTGServiceProvider.h"
#import "TPTGDownloadFileRequest.h"

#define kBaseUrl @"http://api-dev.thanky.me"
#define kBaseAPIUrl [NSString stringWithFormat:@"%@/api/v1", kBaseUrl]
#define kAPIToken @"a6e20c46-0946-4378-b404-11c4c703ae0a"

@implementation TPTGServiceProvider

- (instancetype)init {
    if (self = [super initWithBaseURL:[NSURL URLWithString:kBaseAPIUrl] loginProcess:nil]) {
        self.responseKey = nil;
        self.enableLogging = YES;
    }
    return self;
}

- (void)requestWillSend:(NSMutableURLRequest *)request serviceRequest:(AMServiceRequest *)__unused serviceRequest {
    [request addValue:kAPIToken forHTTPHeaderField:@"x-api-token"];
}

- (NSURLSessionDownloadTask *)downloadFile:(NSString *)fileUrlString requestHandler:(void (^)(NSString *fileUrlString, NSString *filepath, NSError *requestError))requestHandler {
    NSString *fileName = [fileUrlString stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *filePathCache = [self cachePathForFileAtUrl:fileUrlString];
    NSString *filePathBundle = [self filePathBundleWithFileName:fileName];
    if ([[NSFileManager defaultManager] isReadableFileAtPath:filePathCache]) {
        requestHandler(fileUrlString, filePathCache, nil);
    } else if ([[NSFileManager defaultManager] isReadableFileAtPath:filePathBundle]) {
        requestHandler(fileUrlString, filePathBundle, nil);
    } else {
        TPTGDownloadFileRequest *request = [[TPTGDownloadFileRequest alloc] initWithFilePath:fileUrlString];
        return [self downloadFile:request progress:nil completion:^(TPTGDownloadFileRequest *request, NSError *requestError) {
            if (!requestError) {
                [request.fileData writeToFile:filePathCache atomically:YES];
                requestHandler(fileUrlString, filePathCache, nil);
            } else {
                requestHandler(fileUrlString, nil, requestError);
            }
        }];
    }
    return nil;
}

- (NSString *)cachePathForFileAtUrl:(NSString *)fileUrl {
    NSString *fileName = [fileUrl stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return [self filePathCacheDirectoryWithFileName:fileName];
}

- (NSString *)filePathCacheDirectoryWithFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return path;
}

- (NSString *)filePathBundleWithFileName:(NSString *)fileName {
    if (fileName.length < 5) {
        return nil;
    }
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *name = [fileName substringToIndex:fileName.length - 4];
    NSString *type = [fileName substringFromIndex:fileName.length - 3];
    NSString *path = [mainBundle pathForResource:name ofType:type];
    return path;
}

@end
