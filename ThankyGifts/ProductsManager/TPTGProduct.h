//
//  TPTGProduct.h
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGBaseServiceObject.h"
#import "TPTGPrice.h"

@interface TPTGProduct : TPTGBaseServiceObject

@property (nonatomic) NSNumber *uid;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageUrlString;
@property (nonatomic) TPTGPrice *price;

@end
