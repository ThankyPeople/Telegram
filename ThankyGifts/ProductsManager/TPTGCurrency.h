//
//  TPTGCurrency.h
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGBaseServiceObject.h"

@interface TPTGCurrency : TPTGBaseServiceObject

@property (nonatomic) NSString *code;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *sign;

@end
