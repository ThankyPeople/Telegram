//
//  TPTGProductsView.m
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import "TPTGProductsView.h"
#import "TGGifKeyboardBalancedLayout.h"
#import "TPTGThankyGiftCell.h"
#import <LegacyComponents/LegacyComponents.h>
#import "TPTGProductsManager.h"
#import <AMServiceProvider+Common.h>
#import "TPTGCompletePaymentRequest.h"

@interface TPTGProductsView () <TGGifKeyboardBalancedLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) UICollectionView *productsCollectionView;
@property (nonatomic) UIActivityIndicatorView *indicatorView;
@property (nonatomic) UIView *loadingView;
@property (nonatomic) NSArray *products;

@end

@implementation TPTGProductsView

- (instancetype)init {
    if (self = [super init]) {
        TGGifKeyboardBalancedLayout *thankyGiftsCollectionLayout = [[TGGifKeyboardBalancedLayout alloc] init];
        thankyGiftsCollectionLayout.preferredRowSize = TGIsPad() ? 115.0f : 93.0f;
        thankyGiftsCollectionLayout.sectionInset = UIEdgeInsetsZero;
        thankyGiftsCollectionLayout.minimumInteritemSpacing = 0.5f;
        thankyGiftsCollectionLayout.minimumLineSpacing = 0.5f;
        _productsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:thankyGiftsCollectionLayout];
        _productsCollectionView.delegate = self;
        _productsCollectionView.dataSource = self;
        _productsCollectionView.backgroundColor = [UIColor clearColor];
        _productsCollectionView.opaque = false;
        _productsCollectionView.showsHorizontalScrollIndicator = false;
        _productsCollectionView.showsVerticalScrollIndicator = false;
        _productsCollectionView.alwaysBounceVertical = true;
        _productsCollectionView.delaysContentTouches = false;
        [_productsCollectionView registerNib:[UINib nibWithNibName:@"TPTGThankyGiftCell" bundle:nil] forCellWithReuseIdentifier:@"TPTGThankyGiftCell"];
        _productsCollectionView.frame = self.bounds;
        _productsCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_productsCollectionView];
        
        _loadingView = [[UIView alloc] initWithFrame:self.bounds];
        _loadingView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        _loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_loadingView];
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.color = [UIColor blackColor];
        _indicatorView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [_indicatorView startAnimating];
        [_loadingView addSubview:_indicatorView];
        _loadingView.hidden = YES;
        
        [self reload];
        [[TPTGProductsManager sharedInstance] updateProductsWithCompletion:^(__unused id request, __unused NSError *error) {
            [self reload];
        }];
    }
    return self;
}

- (void)reload {
    _products = [TPTGProductsManager sharedInstance].products;
    [_productsCollectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)__unused collectionView layout:(TGGifKeyboardBalancedLayout *)__unused collectionViewLayout preferredSizeForItemAtIndexPath:(NSIndexPath *)__unused indexPath {
    return CGSizeMake(30.0f, 30.0f);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)__unused collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)__unused collectionView numberOfItemsInSection:(NSInteger)__unused section {
    return _products.count;
}

- (CGSize)collectionView:(UICollectionView *)__unused collectionView layout:(UICollectionViewLayout*)__unused collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)__unused indexPath {
    return CGSizeMake(30.0f, 30.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)__unused collectionView layout:(UICollectionViewLayout *)__unused collectionViewLayout insetForSectionAtIndex:(NSInteger)__unused section {
    return UIEdgeInsetsZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TPTGThankyGiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TPTGThankyGiftCell" forIndexPath:indexPath];
    cell.product = _products[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)__unused collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self startPaymentForProduct:_products[indexPath.item]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_didScrollBlock) {
        _didScrollBlock(scrollView);
    }
}

- (void)startPaymentForProduct:(TPTGProduct *)product {
    _loadingView.hidden = NO;
    [[TPTGProductsManager sharedInstance] buyProduct:product completion:^(id request, NSError *error) {
        if (error) {
            _loadingView.hidden = YES;
            [self handleError:error];
        } else {
            [[TPTGProductsManager sharedInstance] completePaymentForProduct:product completion:^(TPTGCompletePaymentRequest *request, NSError *error) {
                if (error) {
                    _loadingView.hidden = YES;
                    [self handleError:error];
                } else {
                    [[TPTGServiceProvider sharedProvider] downloadFile:request.stickerUrlString requestHandler:^(NSString *fileUrlString, NSString *filepath, NSError *requestError) {
                        _loadingView.hidden = YES;
                        if (requestError) {
                            [self handleError:requestError];
                        } else {
                            UIImage *image = [UIImage imageWithContentsOfFile:filepath
                                              ];
                            if (_thankyGiftSelected) {
                                _thankyGiftSelected(image, request.stickerDescription);
                            }
                        }
                    }];
                }
            }];
        }
    }];
}

- (void)handleError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
