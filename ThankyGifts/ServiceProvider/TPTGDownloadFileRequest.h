//
//  TPTGDownloadFileRequest.h
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "AMFileRequest.h"

@interface TPTGDownloadFileRequest : AMFileRequest

- (instancetype)initWithFilePath:(NSString *)path;

@end
