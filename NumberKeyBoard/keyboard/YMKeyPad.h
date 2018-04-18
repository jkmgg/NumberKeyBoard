//
//  YMKeyPad.h
//  Youmiguanjia
//
//  Created by jxrt on 2017/11/23.
//  Copyright © 2017年 北京惠捷宇通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMKeyPad;

typedef NS_ENUM(NSInteger,GkeyboardType){
    calculateKeyboard,
    defualtKeyboard
};
@protocol YMKeyPaddelegate<NSObject>

/**
 键盘每个按钮的点击回调

 @param keyboard 实例
 @param keyContent 当前计算出来的数值
 */
- (void)keyPad:(YMKeyPad *)keyboard didSelectkey:(NSString*)keyContent;

/**
 键盘确定按钮的点击回调

 @param keyboard 实例
 @param keyContent 当前计算出来的数值
 */
- (void)keyPaddidSelectkeyDone:(YMKeyPad *)keyboard keyContent:(NSString*)keyContent;

@end

@interface YMKeyPad : UIView
@property(nonatomic,weak)id <YMKeyPaddelegate>delegate;
+ (instancetype)keyboard:(GkeyboardType)keyboardtype;
- (instancetype)initWithFrame:(CGRect)frame keyboardtype:(GkeyboardType)type;

/**
 要显示的UITextField
 */
@property(nonatomic,copy) UITextField * inputTextFied;

/**
 默认值
 */
@property(nonatomic,copy) NSString * defaultContent;
/**
 确定按钮颜色
 */
@property(nonatomic,assign) int maxLength;
/**
 分割线颜色
 */
@property(nonatomic,strong) UIColor * lineColor;
/**
 数字按钮字体颜色
 */
@property(nonatomic,strong) UIColor * numberTextColor;
/**
 数字按钮颜色
 */
@property(nonatomic,strong) UIColor * numberViewColor;
/**
 确定按钮颜色
 */
@property(nonatomic,strong) UIColor * returnButtonColor;

/**
 删除按钮图片
 */
@property(nonatomic,strong) UIImage * deleteButtonimage;

/**
 键盘下落按钮颜色
 */
@property(nonatomic,strong) UIImage * keyboardDownButtonimage;
@end
