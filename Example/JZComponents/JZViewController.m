//
//  JZViewController.m
//  JZComponents
//
//  Created by Jentle on 05/18/2022.
//  Copyright (c) 2022 Jentle. All rights reserved.
//

#import "JZViewController.h"
#import "JZComponents.h"
#import "Masonry.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface JZViewController ()

@end

@implementation JZViewController

//- (void)injected
//{
//    NSLog(@"I've been injected: %@", self);
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageView = [UIImageView jz_imageWithImageName:@"icon_001"];
    [self.view addSubview:imageView];
    self.view.backgroundColor = UIColor.whiteColor;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@50);
        make.height.equalTo(@100);
    }];
    
    UITextField *textField = [UITextField jz_textFieldWithTextColor:UIColor.blackColor font:UIFont.jz_systemFontSize(16.f) placeholder:@"请输入"];
//    textField.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(20.f);
        make.left.equalTo(@20.f);
        make.right.equalTo(@-20.f);
    }];
    [textField.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > 5) {
            textField.text = [inputString substringToIndex:5];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
