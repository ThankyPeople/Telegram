//
//  TPTGPrice.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGPrice.h"
#import "TPTGCurrency.h"

@implementation TPTGPrice

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    _amount = [NSDecimalNumber decimalNumberWithDecimal:[[dictionary validObjectForKey:@"amount"] decimalValue]];
    _currency = [[TPTGCurrency alloc] initWithDictionary:[dictionary validObjectForKey:@"currency"]];
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObjectOrDoNothing:_amount forKey:@"amount"];
    [dictionary setObjectOrDoNothing:[_currency dictionaryRepresentation] forKey:@"currency"];
    return dictionary;
}

@end
