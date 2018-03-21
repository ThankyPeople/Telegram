//
//  TPTGCurrency.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGCurrency.h"

@implementation TPTGCurrency

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObjectOrDoNothing:_name forKey:@"name"];
    [dictionary setObjectOrDoNothing:_code forKey:@"code"];
    [dictionary setObjectOrDoNothing:_sign forKey:@"sign"];
    return dictionary;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    _name = [dictionary validObjectForKey:@"name"];
    _code = [dictionary validObjectForKey:@"code"];
    _sign = [dictionary validObjectForKey:@"sign"];
}

@end
