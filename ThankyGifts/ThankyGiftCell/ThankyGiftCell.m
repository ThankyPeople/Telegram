//
//  ThankyGiftCell.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/18/18.
//

#import "ThankyGiftCell.h"
#include <stdlib.h>

@interface ThankyGiftCell ()

@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end

@implementation ThankyGiftCell

- (void)setIndex:(NSUInteger)index {
    _index = index;
    _productImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"thankyProduct%ld", index]];
    _priceLabel.text = [NSString stringWithFormat:@"%ldр.", (index + 1) * 100];
}

- (UIImage *)image {
    NSUInteger number = arc4random_uniform(3);
    
    return [UIImage imageNamed:[NSString stringWithFormat:@"%ld%ld", _index, number]];
}

@end
