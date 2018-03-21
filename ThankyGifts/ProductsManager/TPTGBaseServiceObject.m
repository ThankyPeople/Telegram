//
//  TPTGBaseServiceObject.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGBaseServiceObject.h"

@implementation TPTGBaseServiceObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithDictionary:[aDecoder decodeObjectForKey:@"root"]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self dictionaryRepresentation] forKey:@"root"];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self updateWithDictionary:dictionary];
    }
    return self;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    
}

@end
