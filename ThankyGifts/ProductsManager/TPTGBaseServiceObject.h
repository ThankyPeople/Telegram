//
//  TPTGBaseServiceObject.h
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import <Foundation/Foundation.h>
#import <AMNetwork/AMServiceObject.h>
#import <NSDictionary+Validation.h>

@interface TPTGBaseServiceObject : NSObject <AMServiceObject, NSCopying>

- (void)updateWithDictionary:(NSDictionary *)dictionary;

@end
