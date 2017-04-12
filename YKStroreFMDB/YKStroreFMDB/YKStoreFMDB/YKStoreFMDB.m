//
//  YKStoreFMDB.m
//  YKStroreFMDB
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 YoursKing. All rights reserved.
//

#import "YKStoreFMDB.h"
#import "FMDB.h" //数据库

//数据库文件名字
static  NSString *kSqliteName = @"YKStoreFMDB.sqlite";

@implementation YKStoreFMDB

//写入数据库文件
+(NSString *)yk_getYKStoreFMDBSqlite{
    
    //打开沙盒
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //创建数据库文件
    NSString *databaseFilePath = [cachePath stringByAppendingPathComponent:kSqliteName];
    
    return databaseFilePath;
    
}


+(BOOL)yk_storeObj:(id)storeObj page:(NSString *)storePage tableName:(NSString *)tableName{
    
    BOOL sroreSuccessful = NO;
    
    FMDatabase *database = [[FMDatabase alloc]initWithPath:[YKStoreFMDB yk_getYKStoreFMDBSqlite]];

    
    if ([database open]) {
        
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('rowid' integer PRIMARY KEY AUTOINCREMENT NOT NULL,'%@' text DEFAULT '','%@' blob DEFAULT 0)",tableName,@"page",@"obj"];
        
        if ([database executeUpdate:sql]) {
            
            id dataObj = storeObj;
            
            if (storeObj == nil) {
                [database close];
                return sroreSuccessful;
            }

            NSData *objData = [NSKeyedArchiver archivedDataWithRootObject:dataObj];
            
            NSString *page = storePage;
            
            sql = [NSString stringWithFormat:@"INSERT INTO %@ (page,obj) VALUES(:page,:obj)",tableName];
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"page"] = page;
            parameters[@"obj"] = objData;
            
            sroreSuccessful = [database executeUpdate:sql withParameterDictionary:parameters];
        }
        
        [database close];
        
        return sroreSuccessful;
    }
    
    return NO;
}


+(NSDictionary*)yk_readFMDBObjDataWithTableName:(NSString *)tableName{
    
    FMDatabase *database = [[FMDatabase alloc]initWithPath:[YKStoreFMDB yk_getYKStoreFMDBSqlite]];
    
    if ([database open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        FMResultSet *resultSet = [database executeQuery:sql];
        
        NSMutableDictionary *pageObjDict = [NSMutableDictionary dictionary];
        
        while ([resultSet next]) {
            NSData *objData  = [resultSet dataForColumn:@"obj"];
            NSString *page  = [resultSet stringForColumn:@"page"];

            id objFromFMDB = [NSKeyedUnarchiver unarchiveObjectWithData:objData];
            
            //页数对应的obj
            [pageObjDict setObject:objFromFMDB forKey:page];
            
        }
        
        [database close];
        
        
        return [pageObjDict copy];
    }
    return nil;
    
}
//改
+(BOOL)yk_updateFMDBObj:(id)objDict  page:(NSString *)objPage tableName:(NSString *)tableName{
    FMDatabase *database = [[FMDatabase alloc]initWithPath:[YKStoreFMDB yk_getYKStoreFMDBSqlite]];
    
    BOOL upDateSuccessful = NO;

    if ([database open]) {
        NSString *updateSql = [NSString stringWithFormat:
                               @"UPDATE '%@' SET '%@' = '%@' WHERE '%@' = '%@'",
                               tableName,   @"obj",  objDict ,@"page", objPage];
         upDateSuccessful =[database executeUpdate:updateSql];
    }
    
    [database close];
    
    if (upDateSuccessful) {
        return YES;
    }
    return NO;
}
//删
+ (BOOL)yk_deletePage:(NSString *)storePage WithTabel:(NSString *) tableName {
    
    FMDatabase *database = [[FMDatabase alloc]initWithPath:[YKStoreFMDB yk_getYKStoreFMDBSqlite]];

    BOOL deleteSuccessful = NO;

    if ([database open]) {
        
        NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM %@ WHERE page = %@",tableName,storePage];
        
         deleteSuccessful = [database executeUpdate:sqlStr];
        
    }
    [database close];
    
    if (deleteSuccessful) {
        return YES;
    }
    
    return NO;
}

//查
+ (id)yk_selectePage:(NSString *)storePage WithTabel:(NSString *) tableName {
    
    FMDatabase *database = [[FMDatabase alloc]initWithPath:[YKStoreFMDB yk_getYKStoreFMDBSqlite]];
    
    id objFromFMDB;
   
    if ([database open]) {
       //查询语句
//       NSString *sqlStr = @"SELECT NAME,AGE FROM t_test WHERE AGE = 30;";
       NSString *sqlStr = [NSString stringWithFormat:@"SELECT obj FROM %@ WHERE page = %@",tableName,storePage];
       
       //执行sql查询语句(调用FMDB对象方法)
       FMResultSet *result =  [database executeQuery:sqlStr];
       
       while ([result next]) {
           NSData *objData  = [result dataForColumn:@"obj"];

           objFromFMDB = [NSKeyedUnarchiver unarchiveObjectWithData:objData];
        }
    }
    [database close];
    
    return objFromFMDB;

    
    return nil;
}




@end
