#import "UITextField+Localized.h"

@implementation UITextField (Localized)

- (void)setLocalizedText:(NSString *)text
{
    self.text = NSLocalizedString(text, nil);
}

- (void)setLocalizedPlaceholder:(NSString *)placeholder
{
    self.placeholder = NSLocalizedString(placeholder, nil);
}

@end
