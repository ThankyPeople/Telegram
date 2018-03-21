//
//  TPTGThankyGiftCell.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/18/18.
//

#import "TPTGThankyGiftCell.h"
#import "TPTGProductsManager.h"
#import <UIImageView+AFNetworking.h>
#import <stdlib.h>

@interface TPTGThankyGiftCell ()

@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end

@implementation TPTGThankyGiftCell

- (void)setProduct:(TPTGProduct *)product {
    _product = product;

    [_productImageView setImageWithURL:[NSURL URLWithString:product.imageUrlString]];
    
    _priceLabel.text = [NSString stringWithFormat:@"%.2f%@", product.price.amount.floatValue / 100, product.price.currency.sign];
}

@end
