//
//  TPTGProductsView.h
//  Telegraph
//
//  Created by Dmitry Tikhonov on 3/21/18.
//

#import <UIKit/UIKit.h>

@interface TPTGProductsView : UIView

@property (nonatomic, readonly) UICollectionView *productsCollectionView;

@property (nonatomic) void (^thankyGiftSelected)(UIImage *, NSString *);
@property (nonatomic) void (^didScrollBlock)(UIScrollView *);

@end
