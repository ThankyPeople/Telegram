//
//  TPTGCompletePaymentRequest.h
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGBaseServiceRequest.h"

@interface TPTGCompletePaymentRequest : TPTGBaseServiceRequest

@property (nonatomic) NSString *stickerDescription;
@property (nonatomic) NSString *stickerUrlString;

@end
