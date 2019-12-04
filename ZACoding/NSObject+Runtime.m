//
//  NSObject+Runtime.m
//  ZACoding
//
//  Created by 张奥 on 2019/12/3.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>
@implementation NSObject (Runtime)

-(void)encoder:(NSCoder *)aCode{
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i=0 ; i<count; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id value = [self valueForKey:key];
        [aCode encodeObject:value forKey:key];
    }
    free(ivars);
}

-(void)decode:(NSCoder *)aDecode{
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i=0 ; i<count; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id value = [aDecode decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    
}

@end
