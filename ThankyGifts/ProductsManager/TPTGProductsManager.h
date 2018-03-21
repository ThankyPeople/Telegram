//
//  TPTGProductsManager.h
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/20/18.
//

#import <Foundation/Foundation.h>
#import "TPTGServiceProvider.h"
#import "TPTGProduct.h"

@interface TPTGProductsManager : NSObject

@property (nonatomic, readonly) NSArray *products;

+ (instancetype)sharedInstance;
- (void)updateProductsWithCompletion:(RequestCompletion)completion;
- (NSURLSessionDataTask *)buyProduct:(TPTGProduct *)product completion:(RequestCompletion)completion;
- (NSURLSessionDataTask *)completePaymentForProduct:(TPTGProduct *)product completion:(RequestCompletion)completion;

@end
