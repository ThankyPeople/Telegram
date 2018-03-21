//
//  TPTGCompletePaymentRequest.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGCompletePaymentRequest.h"
#import <NSDictionary+Validation.h>

@implementation TPTGCompletePaymentRequest

- (NSString *)path {
    return @"payment/confirm/";
}

- (void)processResponse:(NSDictionary *)response {
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSDictionary *data = [response validObjectForKey:@"data"];
        _stickerDescription = [data validObjectForKey:@"description"];
        _stickerUrlString = [data validObjectForKey:@"stickerUrl"];
    }
}

@end
