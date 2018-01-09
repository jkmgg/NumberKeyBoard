//
//  YMKeyPad.h
//  Youmiguanjia
//
//  Created by jxrt on 2017/11/23.
//  Copyright © 2017年 北京惠捷宇通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMKeyPad;

@protocol YMKeyPaddelegate<NSObject>

- (void)keyPad:(YMKeyPad *)keyboard didSelectkey:(NSString*)keyContent;
- (void)keyPaddidSelectkeyDone:(YMKeyPad *)keyboard keyContent:(NSString*)keyContent;

@end

@interface YMKeyPad : UIView
@property(nonatomic,copy) NSString * defaultContent;
@property(nonatomic,weak)id <YMKeyPaddelegate>delegate;
+ (instancetype)keyboard;
@end
