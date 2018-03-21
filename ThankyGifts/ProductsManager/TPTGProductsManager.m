//
//  TPTGProductsManager.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/20/18.
//

#import "TPTGProductsManager.h"
#import "TPTGServiceProvider.h"
#import "TPTGProductsRequest.h"
#import "TPTGCompletePaymentRequest.h"
#import "TPTGPaymentRequest.h"
#import <AMServiceProvider+Common.h>
#import <NSDictionary+Validation.h>
#import "TPTGProduct.h"

#define kFileName @"productsFile"

@interface TPTGProductsManager ()

@property (nonatomic) NSArray *products;

@end

@implementation TPTGProductsManager

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static TPTGProductsManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _products = [NSKeyedUnarchiver unarchiveObjectWithFile:kFileName];
    }
    return self;
}

- (void)updateProductsWithServiceArray:(NSArray<NSDictionary *> *)serviceArray {
    @synchronized(_products) {
        NSMutableArray *resultArray = [NSMutableArray new];
        for (NSDictionary *dictionary in serviceArray) {
            NSNumber *uid = [dictionary validObjectForKey:@"uid"];
            if (uid) {
                TPTGProduct *product = [_products filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"uid == %@", uid]].firstObject;
                if (!product) {
                    product = [TPTGProduct new];
                }
                [product updateWithDictionary:dictionary];
                [resultArray addObject:product];
            }
        }
        _products = resultArray;
    }
    [NSKeyedArchiver archiveRootObject:_products toFile:kFileName];
}

- (void)updateProductsWithCompletion:(RequestCompletion)completion {
    [[TPTGServiceProvider sharedProvider] send:[TPTGProductsRequest new] completion:^(TPTGProductsRequest *request, NSError *error) {
        [self updateProductsWithServiceArray:request.products];
        if (completion) {
            completion(request, error);
        }
    }];
}

- (NSURLSessionDataTask *)buyProduct:(TPTGProduct *)product completion:(RequestCompletion)completion {
    return [[TPTGServiceProvider sharedProvider] send:[TPTGPaymentRequest new] completion:completion];
}

- (NSURLSessionDataTask *)completePaymentForProduct:(TPTGProduct *)product completion:(RequestCompletion)completion {
    return [[TPTGServiceProvider sharedProvider] send:[TPTGCompletePaymentRequest new] completion:completion];
}

@end
