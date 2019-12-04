//
//  ViewController.m
//  ZACoding
//
//  Created by 张奥 on 2019/12/3.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "ViewController.h"
#import "BaseModel.h"
#import "Manager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        BaseModel *model = [[BaseModel alloc] init];
        model.userID = 72;
        [arr addObject:model];
    }
    [[Manager sharedInstance] saveDataWithPlist:arr];
    
    [self performSelector:@selector(XXXXX) withObject:self afterDelay:3];
}

-(void)XXXXX{
  id data =  [[Manager sharedInstance] getDataWithPlist];
    if ([data isKindOfClass:[NSArray class]]) {
        for (BaseModel *model in data) {
            NSLog(@"%ld",model.userID);
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
