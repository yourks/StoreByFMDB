//
//  YKStoreFMDB.h
//  YKStroreFMDB
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 YoursKing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKStoreFMDB : NSObject

/**
 数据库实例化

 @return YKStoreFMDB
 */
+ (id)sharedInstance;

-(instancetype)init __attribute__((deprecated("Use sharedInstance instead.")));

-(void)storeObj:(id)storeObj page:(NSString *)storePage tableName:(NSString *)tableName;

-(NSDictionary*)readFMDBObjDataWithTableName:(NSString *)tableName;
@end
