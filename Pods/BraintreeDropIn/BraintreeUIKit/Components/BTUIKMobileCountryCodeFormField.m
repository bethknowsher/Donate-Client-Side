#import "BTUIKMobileCountryCodeFormField.h"
#import "BTUIKTextField.h"
#import "BTUIKInputAccessoryToolbar.h"
#import "BTUIKLocalizedString.h"

@implementation BTUIKMobileCountryCodeFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = BTUIKLocalizedString(MOBILE_COUNTRY_CODE_LABEL);
        self.formLabel.text = BTUIKLocalizedString(MOBILE_COUNTRY_CODE_LABEL);
        self.textField.placeholder = @"+65";
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (void)fieldContentDidChange {
    
    NSMutableString *s = [NSMutableString stringWithString:self.textField.text];
    NSUInteger slashLocation = [s rangeOfString:@"+"].location;
    if (slashLocation == NSNotFound && s.length > 0) {
        [s insertString:@"+" atIndex:0];
    } else if (s.length == 1) {
        s = [NSMutableString stringWithString:@""];
    }
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:s];
    self.textField.attributedText = result;
    
    [self updateAppearance];
    [self.delegate formFieldDidChange:self];
}

#pragma mark - Custom accessors

- (BOOL)valid {
    return self.countryCode.length >= 1;
}

- (NSString *)countryCode {
    return [self.textField.text stringByReplacingOccurrencesOfString:@"+" withString:@""];
}

@end
