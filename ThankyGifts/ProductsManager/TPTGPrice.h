//
//  TPTGPrice.h
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGBaseServiceObject.h"
#import "TPTGCurrency.h"

@interface TPTGPrice : TPTGBaseServiceObject

@property (nonatomic) TPTGCurrency *currency;
@property (nonatomic) NSDecimalNumber *amount;

@end
