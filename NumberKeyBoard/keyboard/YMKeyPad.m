//
//  YMKeyPad.m
//  Youmiguanjia
//
//  Created by jxrt on 2017/11/23.
//  Copyright © 2017年 北京惠捷宇通科技有限公司. All rights reserved.
//

#define PrimaryAlphaColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


#import "YMKeyPad.h"
#define keyboardHeight 240
typedef NS_ENUM(NSInteger,KeyboardselectType) {
    KeyboardselectNumber = 10,        //数字
    KeyboardselectDelete,        //删除
    KeyboardselectAddition,      //加号
    KeyboardselectSubtraction,   //减号
    KeyboardselectDecimalpoint,  //小数点
    KeyboardselectDone,          //确认
};
@interface YMKeyPad()
@property(nonatomic,strong) NSArray * tagArray;
@property(nonatomic,copy) NSString * AmountNumber;
@end

@implementation YMKeyPad

//- (NSArray *)tagArray{
//
//    if (_tagArray == nil) {
//    }
//}

+ (instancetype)keyboard{
    
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = PrimaryAlphaColor(83, 90, 112);
        self.AmountNumber = @"";
        for (int i = 0; i<15; i++) {
            UIButton * keybutton = [UIButton buttonWithType:UIButtonTypeCustom];
            keybutton.backgroundColor = PrimaryAlphaColor(51, 68, 85);
            keybutton.titleLabel.font = [UIFont systemFontOfSize:26];
            [self addSubview:keybutton];
            [keybutton addTarget:self action:@selector(keybuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)setDefaultContent:(NSString *)defaultContent{
    _defaultContent = defaultContent;
    if (_defaultContent.length > 0) {
        self.AmountNumber = _defaultContent;
    }else{
        self.AmountNumber = @"";
    }
}

- (void)keybuttonclick:(UIButton *)keybutton{
    
    // 确定按钮点击处理
    if (keybutton.tag == KeyboardselectDone){
        
        if ([self.AmountNumber containsString:@"-"]) {
            NSArray * numberarray = [self.AmountNumber componentsSeparatedByString:@"-"];
            self.AmountNumber = [NSString stringWithFormat:@"%ld",[numberarray[0] integerValue] -[numberarray[1] integerValue]];
        }else if ([self.AmountNumber containsString:@"+"]) {
            NSArray * numberarray = [self.AmountNumber componentsSeparatedByString:@"+"];
            self.AmountNumber = [NSString stringWithFormat:@"%ld",[numberarray[0] integerValue]+[numberarray[1] integerValue]];
        }else{
            
            if ([self.delegate respondsToSelector:@selector(keyPaddidSelectkeyDone:keyContent:)]) {
                
                [self.delegate keyPaddidSelectkeyDone:self keyContent:self.AmountNumber];
            }
            return;
        }
        if (self.AmountNumber.length > 10) {
            self.AmountNumber = [self.AmountNumber substringToIndex:11];
        }
        [self.delegate keyPad:self didSelectkey:self.AmountNumber];
        
    }
    
    if ([self.delegate respondsToSelector:@selector(keyPad:didSelectkey:)]) {
        // 数字按钮点击处理
        if (keybutton.tag < 10) {
            self.AmountNumber = [self.AmountNumber stringByAppendingString:keybutton.titleLabel.text];
            if (self.AmountNumber.length > 10) {
                self.AmountNumber = [self.AmountNumber substringToIndex:11];
            }
            [self.delegate keyPad:self didSelectkey:self.AmountNumber];
        }else{
            if (self.AmountNumber.length == 0) {
                return;
            }
            switch (keybutton.tag) {
                case KeyboardselectDelete:
                {
                    self.AmountNumber = [self.AmountNumber substringToIndex:self.AmountNumber.length-1];
                }
                    break;
                case KeyboardselectAddition:
                {
                    if ([self.AmountNumber containsString:@"-"]) {
                        NSArray * numberarray = [self.AmountNumber componentsSeparatedByString:@"-"];
                        if ([numberarray[1] isEqualToString:@"+"]) {
                            self.AmountNumber = [self.AmountNumber substringToIndex:self.AmountNumber.length-1];
                        }else{
                            self.AmountNumber = [NSString stringWithFormat:@"%ld",[numberarray[0] integerValue]-[numberarray[1] integerValue]];
                        }
                    }
                    if ([self.AmountNumber containsString:@"+"]) {
                        NSArray * numberarray = [self.AmountNumber componentsSeparatedByString:@"+"];
                        self.AmountNumber = [NSString stringWithFormat:@"%ld",[numberarray[0] integerValue]+[numberarray[1] integerValue]];
                    }else{
                    
                        self.AmountNumber = [self.AmountNumber stringByAppendingString:keybutton.titleLabel.text];
                    }
                }
                    break;
                case KeyboardselectSubtraction:
                {
                    if ([self.AmountNumber containsString:@"+"]) {
                        NSArray * numberarray = [self.AmountNumber componentsSeparatedByString:@"+"];
                        if ([numberarray[1] isEqualToString:@"-"]) {
                            self.AmountNumber = [self.AmountNumber substringToIndex:self.AmountNumber.length-1];
                        }else{
                            self.AmountNumber = [NSString stringWithFormat:@"%ld",[numberarray[0] integerValue]+[numberarray[1] integerValue]];
                        }
                    }
                    if ([self.AmountNumber containsString:@"-"]) {
                        NSArray * numberarray = [self.AmountNumber componentsSeparatedByString:@"-"];
                        self.AmountNumber = [NSString stringWithFormat:@"%ld",[numberarray[0] integerValue] -[numberarray[1] integerValue]];
                    }else{
                 
                        self.AmountNumber = [self.AmountNumber stringByAppendingString:keybutton.titleLabel.text];
                    }
                }
                    break;
            
                case KeyboardselectDecimalpoint:
                {
                    if (![self.AmountNumber containsString:@"."]) {
                        self.AmountNumber = [self.AmountNumber stringByAppendingString:@"."];
                    }
                }
                    break;
                default:
                    break;
            }
            if (self.AmountNumber.length > 10) {
                self.AmountNumber = [self.AmountNumber substringToIndex:11];
            }
            [self.delegate keyPad:self didSelectkey:self.AmountNumber];
        }
    }
    UIButton * donebtn = [self viewWithTag:KeyboardselectDone];
    if ([self.AmountNumber containsString:@"-"]||[self.AmountNumber containsString:@"+"]) {
        donebtn.backgroundColor = PrimaryAlphaColor(51, 68, 85);
        [donebtn setTitle:@"=" forState:UIControlStateNormal];
    }else{
        [donebtn setTitle:@"确定" forState:UIControlStateNormal];
        donebtn.backgroundColor = PrimaryAlphaColor(250, 90, 90);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat keybuttonW = (self.frame.size.width - 3)/4;
    CGFloat keybuttonH = (keyboardHeight - 3)/4;

    for (int i = 0; i<self.subviews.count; i++) {
        
        UIButton * keybutton = self.subviews[i];
        keybutton.frame = CGRectMake(i%4*(keybuttonW+0.5), i/4*(keybuttonH+0.5), keybuttonW, keybuttonH);
        if (i/4 == 3) {
            switch (i%4) {
                case 0:
                    [keybutton setTitle:@"·" forState:UIControlStateNormal];
                    keybutton.tag = KeyboardselectDecimalpoint;
                    break;
                case 1:
                    [keybutton setTitle:@"0" forState:UIControlStateNormal];
                    keybutton.tag = 0;
                    break;
                case 2:
                    [keybutton setTitle:@"确定" forState:UIControlStateNormal];
                    keybutton.tag = KeyboardselectDone;
                    break;
                default:
                    break;
            }
        }else if (i%4 == 3){
            keybutton.titleLabel.font = [UIFont systemFontOfSize:35];
            switch (i/4) {
                case 0:
                    [keybutton setImage:[UIImage imageNamed:@"keyPad_delete_icon"] forState:UIControlStateNormal];
                    keybutton.tag = KeyboardselectDelete;
                    break;
                case 1:
                    [keybutton setTitle:@"+" forState:UIControlStateNormal];
                    keybutton.tag = KeyboardselectAddition;
                    break;
                case 2:
                    [keybutton setTitle:@"-" forState:UIControlStateNormal];
                    keybutton.tag = KeyboardselectSubtraction;
                    break;
                default:
                    break;
            }
        }else{
            [keybutton setTitle:[NSString stringWithFormat:@"%d",i/4*3+(i%4+1)] forState:UIControlStateNormal];
            keybutton.tag = i/4*3+(i%4+1);
        }

        if (i == self.subviews.count-1) {
            keybutton.frame = CGRectMake(keybutton.frame.origin.x, keybutton.frame.origin.y, keybuttonW*2, keybutton.frame.size.height);
            keybutton.backgroundColor = PrimaryAlphaColor(250, 90, 90);
            keybutton.titleLabel.font = [UIFont systemFontOfSize:22];
        }
    }
}
@end
