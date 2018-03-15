#import <UIKit/UIKit.h>

#import "TGStickerKeyboardTabPanel.h"

typedef enum {
    TGStickerKeyboardTabSettingsCellSettings,
    TGStickerKeyboardTabSettingsCellGifs,
    TGStickerKeyboardTabSettingsCellTrending,
    TGStickerKeyboardTabSettingsCellThankyGifts
} TGStickerKeyboardTabSettingsCellMode;

@interface TGStickerKeyboardTabSettingsCell : UICollectionViewCell

@property (nonatomic, copy) void (^pressed)();

@property (nonatomic) TGStickerKeyboardTabSettingsCellMode mode;

- (void)setBadge:(NSString *)badge;
- (void)setStyle:(TGStickerKeyboardViewStyle)style;

- (void)setInnerAlpha:(CGFloat)innerAlpha;

@end
