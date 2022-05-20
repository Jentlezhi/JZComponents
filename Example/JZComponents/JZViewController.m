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

@interface JZViewController ()

@end

@implementation JZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSString *content = @"iOS开发者".jz_append(@" 苹果").jz_append( @"swift");
//    UILabel *label = [UILabel jz_labelWithText:content textColor:UIColor.blackColor backgroundColor:UIColor.orangeColor font:[UIFont systemFontOfSize:15.f] textAlignment:NSTextAlignmentLeft];
//    [self.view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
//
//    BOOL ret = @"aad".jz_isEqual(@"aad");
//    NSLog(@"ret = %d",ret);
//
//    NSLog(@"%@",NSString.jz_guard(nil));
//
////    NSLog(@"%@",NSString.randomRangedLetters(1,10));
////    NSLog(@"%@",NSString.randomChineseLetters(10));
////    NSLog(@"%@",NSString.randomRangedChineseLetters(0,10));
//
//    NSArray *array = @[@"a",@"b"];
//    NSLog(@"%@",array[1]);
//    NSLog(@"%@",array[-1]);
//    NSLog(@"%@",[array objectAtIndex:100]);
//
//    NSMutableArray *marray = @[@"a",@"b", @"c"].mutableCopy;
////    [marray addObject:nil];
//    NSLog(@"%@",[marray objectAtIndex:-1]);
    
    UIImageView *imageView = [UIImageView jz_imageWithImageName:@"icon_001"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@50);
        make.height.equalTo(@100);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
