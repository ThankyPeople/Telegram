//
//  TPTGServiceProvider.h
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/20/18.
//

#import "AMServiceProvider.h"

@interface TPTGServiceProvider : AMServiceProvider

- (NSURLSessionDownloadTask *)downloadFile:(NSString *)fileUrlString requestHandler:(void (^)(NSString *fileUrlString, NSString *filepath, NSError *requestError))requestHandler;

@end
