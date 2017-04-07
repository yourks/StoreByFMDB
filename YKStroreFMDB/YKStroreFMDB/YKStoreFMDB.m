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


@implementation YKStoreFMDB{
    FMDatabase *_database;
}
//单例化
+ (id)sharedInstance{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _database = [[FMDatabase alloc]initWithPath:[self getYKStoreFMDBSqlite]];
    }
    return self;
}

//写入数据库文件
-(NSString *)getYKStoreFMDBSqlite{
    
    //打开沙盒
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //创建数据库文件
    NSString *databaseFilePath = [cachePath stringByAppendingPathComponent:kSqliteName];
    
    return databaseFilePath;
    
}


-(void)storeObj:(id)storeObj page:(NSString *)storePage tableName:(NSString *)tableName{
    
    if ([_database open]) {
        
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('rowid' integer PRIMARY KEY AUTOINCREMENT NOT NULL,'%@' text DEFAULT '','%@' blob DEFAULT 0)",tableName,@"page",@"obj"];
        
        if ([_database executeUpdate:sql]) {
            
            id dataObj = storeObj;
            
            if (storeObj == nil) {
                return;
            }
            
            NSData *objData = [NSKeyedArchiver archivedDataWithRootObject:dataObj];
            
//            NSString *objStr = [[NSString alloc] initWithData:objData encoding:NSUTF8StringEncoding];
            
//            NSString *obj = objStr;
            NSString *page = storePage;
            
            sql = [NSString stringWithFormat:@"INSERT INTO %@ (page,obj) VALUES(:page,:obj)",tableName];
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"page"] = page;
            parameters[@"obj"] = objData;
            
            BOOL insertOK = [_database executeUpdate:sql withParameterDictionary:parameters];
            NSLog(@"%d",insertOK);
        }
        [_database close];
    }
}


-(NSDictionary*)readFMDBObjDataWithTableName:(NSString *)tableName{
    
    if ([_database open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        FMResultSet *resultSet = [_database executeQuery:sql];
        
        NSMutableDictionary *pageObjDict = [NSMutableDictionary dictionary];
        
        while ([resultSet next]) {
            NSData *objData  = [resultSet dataForColumn:@"obj"];
            NSString *page  = [resultSet stringForColumn:@"page"];

//            NSData *objData = [obj dataUsingEncoding:NSUTF8StringEncoding];
            //NSLog(@"%@",objArrFromFMDB);
            id objFromFMDB = [NSKeyedUnarchiver unarchiveObjectWithData:objData];
            //页数对应的obj
            [pageObjDict setObject:objFromFMDB forKey:page];
            
        }
        
        [_database close];
        
        
        return [pageObjDict copy];
    }
    return nil;
    
}

-(BOOL)upDateFMDBObj:(id)objDict  page:(NSString *)objPage tableName:(NSString *)tableName{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *databaseFilePath = [cachePath stringByAppendingPathComponent:kSqliteName];
    
    FMDatabase *database = [[FMDatabase alloc]initWithPath:databaseFilePath];
    if ([database open]) {
        NSString *updateSql = [NSString stringWithFormat:
                               @"UPDATE '%@' SET '%@' = '%@' WHERE '%@' = '%@'",
                               tableName,   @"obj",  objDict ,@"page", objPage];
        BOOL isupDate =[database executeUpdate:updateSql];
        if (isupDate) {
            return YES;
        }
        
    }
    
    [database close];
    
    return NO;
    
}

@end
