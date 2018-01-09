//
//  ViewController.m
//  NumberKeyBoard
//
//  Created by jxrt on 2018/1/8.
//  Copyright © 2018年 Gjmk. All rights reserved.
//

#import "ViewController.h"
#import "YMKeyPad.h"

@interface ViewController ()<YMKeyPaddelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFied;
@property (nonatomic, copy) NSString* AmountNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.AmountNumber = @"";
    self.textFied.textColor = [UIColor redColor];
    self.textFied.text = @"¥0.00";
    self.textFied.tintColor = [UIColor redColor];
    YMKeyPad * keyboard = [YMKeyPad keyboard];
    keyboard.delegate = self;
    keyboard.defaultContent = self.AmountNumber;
    keyboard.frame = CGRectMake(0, 0, self.view.frame.size.width, 240);
    self.textFied.inputView = keyboard;
    [self.textFied becomeFirstResponder];
    // Do any additional setup after loading the view, typically from a nib.
}

//键盘点击代理   
- (void)keyPad:(YMKeyPad *)keyboard didSelectkey:(NSString *)keyContent{
    
    if (keyContent.length == 0) {
        self.textFied.text = @"";
    }else{
        self.textFied.text = [NSString stringWithFormat:@"¥%@",keyContent];
    }
}
- (void)keyPaddidSelectkeyDone:(YMKeyPad *)keyboard keyContent:(NSString *)keyContent{
    
    [self.textFied resignFirstResponder];
}


@end
