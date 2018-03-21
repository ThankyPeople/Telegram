//
//  TPTGProduct.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGProduct.h"
#import "TPTGPrice.h"

@implementation TPTGProduct

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    _name = [dictionary validObjectForKey:@"name"];
    _uid = [dictionary validObjectForKey:@"uid"];
    _price = [[TPTGPrice alloc] initWithDictionary:[dictionary validObjectForKey:@"price"]];
    _imageUrlString = [dictionary validObjectForKey:@"image"];
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObjectOrDoNothing:_name forKey:@"name"];
    [dictionary setObjectOrDoNothing:_uid forKey:@"uid"];
    [dictionary setObjectOrDoNothing:[_price dictionaryRepresentation] forKey:@"price"];
    [dictionary setObjectOrDoNothing:_imageUrlString forKey:@"image"];
    return dictionary;
}

@end
