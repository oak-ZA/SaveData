//
//  Manager.m
//  ZACoding
//
//  Created by 张奥 on 2019/12/3.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "Manager.h"
#import <sqlite3.h>

@interface Manager(){
    sqlite3     *_db;
}

@end
@implementation Manager

// 单例
+ (Manager *)sharedInstance{
    static Manager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager = [[Manager alloc] init];
    });
    return manager;
}

#pragma mark ----- NSKeyedArchiver  NSKeyedUnarchiver

-(void)saveDataWithPlist:(id)data{
    NSString *filePath = [self getFilePath];
    //归档
    [NSKeyedArchiver archiveRootObject:data toFile:filePath];
}

-(id)getDataWithPlist{
    NSString *filePath = [self getFilePath];
    //解档
    id data = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return data;
}

-(NSString *)getFilePath{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"data.plist"];
    return filePath;
}

#pragma mark ----- NSUserDefaults

-(void)saveObjWithUserDefaults:(id)data{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"NSUserDefaults"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(id)getObjWithUserDefaults{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"NSUserDefaults"];
}


#pragma mark -------

-(void)createSqlite{
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [document stringByAppendingPathComponent:@"student.sqlite"];
    const char *cfileName = fileName.UTF8String;
    int result = sqlite3_open(cfileName, &_db);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        //创建表
        const char *sql = "CREATE TABLE IF EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,age integer NOT NULL);";
        char *errMsg = NULL;
        result = sqlite3_exec(_db, sql, NULL, NULL, &errMsg);
        if (result == SQLITE_OK) {
            NSLog(@"创建数据库成功");
        }else{
            NSLog(@"创建数据库失败");
        }
    }else{
        NSLog(@"打开数据库失败");
    }
    
}

-(void)insertDataIntoSqlite{
    
    for (int i=0 ; i<20; i++) {
        NSString *name = [NSString stringWithFormat:@"嘻嘻--%d",arc4random_uniform(100)];
        int age = arc4random_uniform(20)+10;
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_student (name,age) VALUES ('%@',%d);",name,age];
        
        //sql语句
        char *errMsg = NULL;
        sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errMsg);
        if (errMsg) {
            NSLog(@"插入数据失败----%s",errMsg);
        }else{
            NSLog(@"插入数据成功");
        }
    }
    
}

-(void)selectDataInSqlite{
    
    const char *sql = "SELECT id,name,age FROM t_student WHERE age<20";
    sqlite3_stmt *stm = NULL;
    
    if (sqlite3_prepare_v2(_db, sql, -1, &stm, NULL) == SQLITE_OK) {
        NSLog(@"查询语句没有问题");
        
        while (sqlite3_step(stm) == SQLITE_ROW) {//找到一条记录
            //取出数据
            //取出第0列(int类型的值)
            int ID = sqlite3_column_int(stm, 0);
            //取出第一列字段的值(text类型的值)
            const unsigned char *name = sqlite3_column_text(stm, 1);
            //取出第二列字段的值
            int age = sqlite3_column_int(stm, 2);
            NSLog(@"%d===%s===%d",ID,name,age);
        }
    }else{
        NSLog(@"查询语句错误");
    }
    
}















@end
