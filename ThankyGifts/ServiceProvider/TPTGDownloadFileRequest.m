//
//  TPTGDownloadFileRequest.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGDownloadFileRequest.h"

@interface TPTGDownloadFileRequest ()

@property (nonatomic, strong) NSString *fileURL;

@end

@implementation TPTGDownloadFileRequest

- (instancetype)initWithFilePath:(NSString *)path {
    if(self = [super init]) {
        self.fileURL = path;
    }
    
    return self;
}

- (NSString *)method {
    return @"GET";
}

- (NSString *)path {
    return self.fileURL;
}

@end
