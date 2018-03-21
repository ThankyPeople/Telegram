//
//  TPTGProductsRequest.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/20/18.
//

#import "TPTGProductsRequest.h"
#import <NSDictionary+Validation.h>

@implementation TPTGProductsRequest

- (NSString *)path {
    return @"product/";
}

- (NSString *)method {
    return @"GET";
}

- (void)processResponse:(NSDictionary *)response {
    NSArray *products = [response validObjectForKey:@"data"];
    if ([products isKindOfClass:NSArray.class]) {
        _products = products;
    }
}

- (NSString *)reuseId {
    return @"TPTGProductsRequest";
}

@end
