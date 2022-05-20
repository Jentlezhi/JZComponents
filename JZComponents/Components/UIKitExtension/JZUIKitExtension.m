//
//  JZUIKitExtension.m
//  GitHub
//
//  Created by Jentle-Zhi on 2020/4/15.
//  Copyright © 2020 GitHub. All rights reserved.
//

#import "JZUIKitExtension.h"


@implementation NSMutableArray (JZExtension)

/**
 添加视图的方法.
 @param subview  - 视图.
 */
- (void)jz_addSubview:(nonnull UIView *)subview {
    if (![subview isKindOfClass:[UIView class]]) {return;}
    [self addObject:subview];
}

@end

@implementation UITableViewCell (JZExtension)

/**
 聚合添加组件和布局组件.
 @param addBlock     - 添加的代码块.
 @param layoutBlock  - 布局的代码块.
 */
- (void)jz_addSubViews:(NSMutableArray<UIView *>*(^)(NSMutableArray <UIView *>*subViews))addBlock
     layoutSubViews:(void(^)(void))layoutBlock {
    NSMutableArray *mArray = NSMutableArray.new;
    if (addBlock) {
        mArray = addBlock(mArray);
    }
    [mArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [self.contentView addSubview:obj];
        }
    }];
    !layoutBlock?:layoutBlock();
}

@end

@implementation UIView (JZExtension)

/**
 聚合添加组件和布局组件.
 @param addBlock     - 添加的代码块.
 @param layoutBlock  - 布局的代码块.
 */
- (void)jz_addSubViews:(NSMutableArray<UIView *>*(^)(NSMutableArray <UIView *>*subViews))addBlock
     layoutSubViews:(void(^)(void))layoutBlock {
    NSMutableArray *mArray = NSMutableArray.new;
    if (addBlock) {
        mArray = addBlock(mArray);
    }
    [mArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [self addSubview:obj];
        }
    }];
    !layoutBlock?:layoutBlock();
}

/**
 设置内容太多不被压缩.
 @param expanded  - 是否展开，不被压缩.
 */
- (void)setMoreExpanded:(BOOL)expanded {
    if (expanded) {
        //设置抗压缩，值越大越不容易压缩
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
}

/**
 设置内容不足不被压缩.
 @param expanded  - 是否拉伸.
 */
- (void)setLessExpanded:(BOOL)expanded {
    if (expanded) {
        //设置抗拉伸，值越小越容易被拉伸
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    }
}

@end

@implementation UIFont (JZExtension)

+ (UIFont * _Nonnull (^)(CGFloat))jz_systemFontSize {
    return ^(CGFloat fontSize){
        return [UIFont systemFontOfSize:fontSize];
    };
}

+ (UIFont * _Nonnull (^)(CGFloat))jz_boldSystemFontSize {
    return ^(CGFloat fontSize){
        return [UIFont boldSystemFontOfSize:fontSize];
    };
}

@end

@implementation UIColor (JZExtension)

/**
 快速创建16进制颜色：链式调用.
 @return 颜色.
 */
+ (UIColor * _Nonnull (^)(NSString * _Nonnull))jz_hexColor {
    return ^(NSString *hexColor){
        return [UIColor jz_colorWithHexColor:hexColor];
    };
}
/**
 16进制颜色.
 @param hexValue - 16进制色值.
 @return 颜色.
 */
+ (UIColor *)jz_colorWithHexColor:(NSString *)hexValue {
    if ([hexValue length] <6){//长度不合法
        return UIColor.blackColor;
    }
    NSString *colorString = [[hexValue stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self _colorComponentFrom: colorString start: 0 length: 1];
            green = [self _colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self _colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self _colorComponentFrom: colorString start: 0 length: 1];
            red   = [self _colorComponentFrom: colorString start: 1 length: 1];
            green = [self _colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self _colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self _colorComponentFrom: colorString start: 0 length: 2];
            green = [self _colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self _colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self _colorComponentFrom: colorString start: 0 length: 2];
            red   = [self _colorComponentFrom: colorString start: 2 length: 2];
            green = [self _colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self _colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            blue=0;
            green=0;
            red=0;
            alpha=0;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}


+ (CGFloat)_colorComponentFrom:(NSString *)string
                        start:(NSUInteger)start
                       length:(NSUInteger)length {
    unsigned hexComponent;
    @try{
        NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
        NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
        
        [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    }
    @catch(NSException *exception){}
    @finally{}
    return hexComponent / 255.0;
}

/**
 随机颜色.
 @return 颜色.
 */
+ (instancetype)jz_randomColor {
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    CGFloat a = arc4random_uniform(256);
    return [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0];
}

/**
 适配暗黑.
 @param normalColor    - normal颜色.
 @param darkColor      - 暗黑颜色.
 @return 颜色.
 */
+ (UIColor *)jz_colorWithNormalColor:(NSString *)normalColor
                           darkColor:(NSString *)darkColor {
    
    if (@available(iOS 13.0, *)) {
        UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return [UIColor jz_colorWithHexColor:normalColor];
            }else {
                return [UIColor jz_colorWithHexColor:darkColor];
            }
        }];
        return dyColor;
    } else {
        return [UIColor jz_colorWithHexColor:normalColor];
    }
}


@end

@implementation UILabel (JZExtension)

///hook住setText方法，处理nil的情况
//+ (void)initialize {
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        RSSwizzleInstanceMethod(self,
//                                @selector(setText:),
//                                RSSWReturnType(void),
//                                RSSWArguments(NSString *s),
//                                RSSWReplacement(
//        {
//            NSString *c = s == nil ? @"" : s;
//            RSSWCallOriginal(c);
//        }), 0, NULL);
//    });
//}


/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                       textColor:(UIColor *)textColor {
    
    return [self jz_labelWithText:text textColor:textColor font:[UIFont systemFontOfSize:16.f]];
}

/**
 快速创建label.
 @param textColor   - 文字颜色.
 @param font        - 字体.
 @return label对象.
 */
+ (instancetype)jz_labelWithTextColor:(UIColor *)textColor
                            font:(UIFont *)font {
    
    return [self jz_labelWithText:nil textColor:textColor font:font];
}

/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @param font          - 字体.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font {
    
    return [self jz_labelWithText:text textColor:textColor font:font textAlignment:NSTextAlignmentLeft];
}

/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @param font          - 字体.
 @param textAlignment - 文字对齐方式.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment {
    
    return [self jz_labelWithText:text textColor:textColor backgroundColor:nil font:font textAlignment:textAlignment];
}

/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @param font          - 字体.
 @param textAlignment - 文字对齐方式.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
              backgroundColor:(nullable UIColor *)backgroundColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment {
    
    return [self jz_labelWithText:text textColor:textColor backgroundColor:backgroundColor font:font textAlignment:textAlignment moreExpanded:NO];
}

/**
 快速创建label.
 @param text              - 文字内容.
 @param textColor         - 文字颜色.
 @param backgroundColor   - 背景颜色.
 @param font              - 字体.
 @param textAlignment     - 文字对齐方式.
 @param moreExpanded      - 文字过长是否不被压缩
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
              backgroundColor:(nullable UIColor *)backgroundColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment  moreExpanded:(BOOL)moreExpanded {
    UILayoutPriority layoutPriority = moreExpanded ? UILayoutPriorityRequired : UILayoutPriorityDefaultHigh;
    return [self jz_labelWithText:text textColor:textColor backgroundColor:backgroundColor font:font textAlignment:textAlignment contentHuggingPriority:UILayoutPriorityDefaultLow compressionPriority:layoutPriority];
}

/**
 快速创建label.
 @param text                 - 文字内容.
 @param textColor            - 文字颜色.
 @param backgroundColor      - 背景颜色.
 @param font                 - 字体.
 @param textAlignment        - 文字对齐方式.
 @param contentHuggingPriority  - 抗伸缩优先级.
 @param compressionPriority     - 抗压缩优先级.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
              backgroundColor:(nullable UIColor *)backgroundColor
                         font:(UIFont *)font
                textAlignment:(NSTextAlignment)textAlignment  contentHuggingPriority:(UILayoutPriority)contentHuggingPriority compressionPriority:(UILayoutPriority)compressionPriority{
    UILabel *l = UILabel.new;
    l.textColor = textColor;
    if (backgroundColor) {
        l.backgroundColor = backgroundColor;
    }
    l.textAlignment = textAlignment;
    l.font = font;
    l.text = text;
    [l setContentHuggingPriority:contentHuggingPriority forAxis:UILayoutConstraintAxisHorizontal];
    [l setContentCompressionResistancePriority:compressionPriority forAxis:UILayoutConstraintAxisHorizontal];
    [l sizeToFit];
    return l;
}


@end

@implementation UIButton (JZExtension)

/**
 快速创建Button.
 @param title             - 标题.
 @param titleColor        - 标题颜色.
 @param titleFont         - 标题字体.
 @return Button.
 */
+ (instancetype)jz_buttonWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                      titleFont:(nullable UIFont *)titleFont {
    
    return [self jz_buttonWithTitle:title titleColor:titleColor titleFont:titleFont cornerRadius:0 backgroundColor:nil];
}

/**
 快速创建Button.
 @param titleColor        - 标题颜色.
 @param titleFont         - 标题字体.
 @param cornerRadius      - 圆角.
 @param backgroundColor   - 背景色.
 @return Button.
 */
+ (instancetype)jz_buttonWithTitleColor:(nullable UIColor *)titleColor
                      titleFont:(nullable UIFont *)titleFont
                   cornerRadius:(CGFloat)cornerRadius
                   backgroundColor:(UIColor *)backgroundColor {
    
    return [self jz_buttonWithTitle:nil titleColor:titleColor titleFont:titleFont cornerRadius:cornerRadius backgroundColor:backgroundColor];
}
/**
 快速创建Button.
 @param title             - 标题.
 @param titleColor        - 标题颜色.
 @param titleFont         - 标题字体.
 @param cornerRadius      - 圆角.
 @param backgroundColor   - 背景色.
 @return Button.
 */
+ (instancetype)jz_buttonWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                      titleFont:(nullable UIFont *)titleFont
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor {
    
    UIButton *btn = UIButton.new;
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateHighlighted];
    }
    btn.titleLabel.font = titleFont;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateHighlighted];
    if (cornerRadius > 0) {
        btn.layer.cornerRadius = cornerRadius;
    }
    if (backgroundColor) {
        btn.backgroundColor = backgroundColor;
    }
    return btn;
}

@end

@implementation UIImageView (JZExtension)

/**
 快速创建UIImageView.
 @param imageName  - 图片文件名.
 @return UIImageView对象.
 */
+ (instancetype)jz_imageWithImageName:(NSString *)imageName {
    if (imageName == nil || !imageName.length) {
        return nil;
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

@end

@implementation UITextField (JZExtension)

/**
 快速创建textField.
 @param textColor        - 文字颜色.
 @param font             - 字体.
 @param placeholder      - 占位文字.
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                              placeholder:(nullable NSString *)placeholder {
    
    return [self jz_textFieldWithTextColor:textColor font:font keyboardType:UIKeyboardTypeDefault placeholder:placeholder];
}
/**
 快速创建textField.
 @param textColor        - 文字颜色.
 @param font             - 字体.
 @param keyboardType     - 键盘类型.
 @param placeholder      - 占位文字.
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                             keyboardType:(UIKeyboardType)keyboardType
                              placeholder:(nullable NSString *)placeholder {
    return [self jz_textFieldWithTextColor:textColor font:font keyboardType:keyboardType placeholder:placeholder placeholderColor:nil];
}
/**
 快速创建textField.
 @param textColor        - 文字颜色.
 @param font             - 字体.
 @param keyboardType     - 键盘类型.
 @param placeholder      - 占位文字.
 @param placeholderColor - 占位文字颜色.
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                             keyboardType:(UIKeyboardType)keyboardType
                              placeholder:(nullable NSString *)placeholder
                         placeholderColor:(nullable UIColor *)placeholderColor{
    
    return [self jz_textFieldWithTextColor:textColor font:font keyboardType:keyboardType clearButtonMode:UITextFieldViewModeNever placeholder:placeholder placeholderColor:placeholderColor];
}
/**
 快速创建textField.
 @param textColor        - 文字颜色.
 @param font             - 字体.
 @param keyboardType     - 键盘类型.
 @param clearButtonMode  - 清除按钮的样式.
 @param placeholder      - 占位文字.
 @param placeholderColor - 占位文字颜色.
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                             keyboardType:(UIKeyboardType)keyboardType
                          clearButtonMode:(UITextFieldViewMode)clearButtonMode
                              placeholder:(nullable NSString *)placeholder
                         placeholderColor:(nullable UIColor *)placeholderColor {
    return [self jz_textFieldWithTextColor:textColor font:font textAlignment:NSTextAlignmentLeft keyboardType:keyboardType clearButtonMode:clearButtonMode placeholder:placeholder placeholderColor:placeholderColor];
    
}

/**
 快速创建textField.
 @param textColor        - 文字颜色.
 @param font             - 字体.
 @param textAlignment    - 文字对齐方式.
 @param keyboardType     - 键盘类型.
 @param clearButtonMode  - 清除按钮的样式.
 @param placeholder      - 占位文字.
 @param placeholderColor - 占位文字颜色.
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                            textAlignment:(NSTextAlignment)textAlignment
                             keyboardType:(UIKeyboardType)keyboardType
                          clearButtonMode:(UITextFieldViewMode)clearButtonMode
                              placeholder:(nullable NSString *)placeholder
                         placeholderColor:(nullable UIColor *)placeholderColor{
    
    UITextField *customTF = UITextField.new;
    customTF.font = font;
    customTF.textColor =  textColor;
    customTF.keyboardType = keyboardType;
    customTF.textAlignment = textAlignment;
    customTF.placeholder = placeholder;
    customTF.clearButtonMode = clearButtonMode;
    if (!placeholderColor) {
        placeholderColor = [UIColor colorWithRed:182.f green:182.f blue:182.f alpha:1.f];
    }
    [customTF jz_setPlaceholder:placeholder withFont:font fontColor:placeholderColor];
    
    return customTF;
}

- (void)jz_setPlaceholder:(NSString *)placeholder
              withFont:(UIFont *)font
             fontColor:(UIColor *)fontColor {
    placeholder = placeholder == nil ? self.placeholder : placeholder;
    if (placeholder == nil || placeholder.length == 0) {
        return;
    }
    font = font == nil ? self.font : font;
    fontColor = fontColor == nil ? self.textColor : fontColor;
    if (font == nil || fontColor == nil) {
        return;
    }
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: fontColor, NSFontAttributeName: font}];
    
}

@end

@implementation UIDevice (JZExtension)

+ (CGFloat)safeAreaTopMargin {
    return [self safeAreaInsets].top;
}

+ (CGFloat)safeAreaBottomMargin {
    return [self safeAreaInsets].bottom;
}

+ (UIEdgeInsets)safeAreaInsets {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}


@end
