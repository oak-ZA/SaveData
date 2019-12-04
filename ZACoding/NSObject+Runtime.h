//
//  NSObject+Runtime.h
//  ZACoding
//
//  Created by 张奥 on 2019/12/3.
//  Copyright © 2019 张奥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)
-(void)encoder:(NSCoder *)aCode;
-(void)decode:(NSCoder *)aDecode;
@end
