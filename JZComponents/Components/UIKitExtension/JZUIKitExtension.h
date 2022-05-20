//
//  JZUIKitExtension.h
//  GitHub
//
//  Created by Jentle-Zhi on 2020/4/15.
//  Copyright © 2020 GitHub. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (JZExtension)

/**
 添加视图的方法.
 @param subview  - 视图.
 */
- (void)jz_addSubview:(nonnull UIView *)subview;

@end

@interface UITableViewCell (JZExtension)

/**
 聚合添加组件和布局组件.
 @param addBlock     - 添加的代码块.
 @param layoutBlock  - 布局的代码块.
 */
- (void)jz_addSubViews:(NSMutableArray<UIView *>*(^)(NSMutableArray <UIView *>*subViews))addBlock
     layoutSubViews:(void(^)(void))layoutBlock;

@end

@interface UIView (JZExtension)

/**
 聚合添加组件和布局组件.
 @param addBlock     - 添加的代码块.
 @param layoutBlock  - 布局的代码块.
 */
- (void)jz_addSubViews:(NSMutableArray<UIView *>*(^)(NSMutableArray <UIView *>*subViews))addBlock
     layoutSubViews:(void(^)(void))layoutBlock;

/**
 自动布局-设置内容太多时不被压缩.
 @param expanded  - 是否展开，不被压缩.
 */
- (void)setMoreExpanded:(BOOL)expanded;

/**
 自动布局-设置内容不足不被压缩.
 @param expanded  - 是否拉伸.
 */
- (void)setLessExpanded:(BOOL)expanded;

@end

@interface UIFont (JZExtension)

/**
 快速创建系统字体：链式调用.
 @param fontSize - 系统字体大小.
 @return 指定大小的字体.
 */
@property(copy, nonatomic, readonly, class) UIFont *(^jz_systemFontSize)(CGFloat fontSize);

/**
 快速创建系统加粗字体：链式调用.
 @param fontSize - 系统字体大小.
 @return 指定大小加粗的字体.
 */
@property(copy, nonatomic, readonly, class) UIFont *(^jz_boldSystemFontSize)(CGFloat fontSize);

@end

@interface UIColor (JZExtension)

/**
 快速创建16进制颜色：链式调用.
 @param hexValue - 16进制色值.
 @return 颜色.
 */
@property(copy, nonatomic, readonly, class) UIColor *(^jz_hexColor)(NSString *hexColor);
/**
 16进制颜色.
 @param hexValue - 16进制色值.
 @return 颜色.
 */
+ (UIColor *)jz_colorWithHexColor:(NSString *)hexValue;

/**
 随机颜色.
 @return 颜色.
 */
+ (instancetype)jz_randomColor;

/**
 适配暗黑.
 @param normalColor    - normal颜色.
 @param darkColor      - 暗黑颜色.
 @return 颜色.
 */
+ (UIColor *)jz_colorWithNormalColor:(NSString *)normalColor
                           darkColor:(NSString *)darkColor;


@end

@interface UILabel (JZExtension)
/**
 快速创建label.
 @param textColor   - 文字颜色.
 @param font        - 字体.
 @return label对象.
 */
+ (instancetype)jz_labelWithTextColor:(UIColor *)textColor
                                 font:(UIFont *)font;
/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                       textColor:(UIColor *)textColor;

/**
 快速创建label.
 @param text          - 文字内容.
 @param textColor     - 文字颜色.
 @param font          - 字体.
 @return label对象.
 */
+ (instancetype)jz_labelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                            font:(UIFont *)font;

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
                   textAlignment:(NSTextAlignment)textAlignment;

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
                   textAlignment:(NSTextAlignment)textAlignment;

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
                   textAlignment:(NSTextAlignment)textAlignment  moreExpanded:(BOOL)moreExpanded;

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
                   textAlignment:(NSTextAlignment)textAlignment  contentHuggingPriority:(UILayoutPriority)contentHuggingPriority compressionPriority:(UILayoutPriority)compressionPriority;

@end

@interface UIButton (JZExtension)
/**
 快速创建Button.
 @param title             - 标题.
 @param titleColor        - 标题颜色.
 @param titleFont         - 标题字体.
 @return Button.
 */
+ (instancetype)jz_buttonWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                      titleFont:(nullable UIFont *)titleFont;
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
                        backgroundColor:(UIColor *)backgroundColor;
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
                backgroundColor:(UIColor *)backgroundColor;

@end

@interface UIImageView (JZExtension)

/**
 快速创建UIImageView.
 @param imageName  - 图片文件名.
 @return UIImageView对象.
 */
+ (instancetype)jz_imageWithImageName:(NSString *)imageName;

@end

@interface UIImage (JZExtension)

@end

@interface UITextField (JZExtension)

/**
 快速创建textField.
 @param textColor        - 文字颜色.
 @param font             - 字体.
 @param placeholder      - 占位文字.
 @return textField.
 */
+ (instancetype)jz_textFieldWithTextColor:(nullable UIColor *)textColor
                                     font:(nullable UIFont *)font
                              placeholder:(nullable NSString *)placeholder;
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
                              placeholder:(nullable NSString *)placeholder;
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
                         placeholderColor:(nullable UIColor *)placeholderColor;
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
                         placeholderColor:(nullable UIColor *)placeholderColor;

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
                         placeholderColor:(nullable UIColor *)placeholderColor;

@end

@interface UIDevice (JZExtension)

@property(assign, nonatomic, class, readonly) CGFloat safeAreaTopMargin;

@property(assign, nonatomic, class, readonly) CGFloat safeAreaBottomMargin;

@property(assign, nonatomic, class, readonly) UIEdgeInsets safeAreaInsets;

@end

NS_ASSUME_NONNULL_END
