//
//  Manager.h
//  ZACoding
//
//  Created by 张奥 on 2019/12/3.
//  Copyright © 2019 张奥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject
+ (Manager *)sharedInstance;
//保存
-(void)saveDataWithPlist:(id)data;
//读取
-(id)getDataWithPlist;
//保存到用户偏好设置
-(void)saveObjWithUserDefaults:(id)data;
//读取用户偏好设置里的数据
-(id)getObjWithUserDefaults
@end
