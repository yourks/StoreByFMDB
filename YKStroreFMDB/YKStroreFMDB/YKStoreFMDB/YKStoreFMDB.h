//
//  YKStoreFMDB.h
//  YKStroreFMDB
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 YoursKing. All rights reserved.
//
/*
 
 所有存储方法只应用于NSString，NSDictionary,NSArray,NSData或者NSNumber
 
 出现错误
 -[XXXXXXX(你定义的类) encodeWithCoder:]: unrecognized selector sent to instance 0x8ec89e0'
 
这个问题，字面意思就是你定义的的类的encodeWithCoder:方法找不到
出现了这个问题,那么你现在肯定是调用了
 -(BOOL)yk_storeObj:(id)storeObj page:(NSString *)storePage tableName:(NSString *)tableName;
你想把自定义的类归档到沙盒里面去
 
但是oc只支持NSString，NSDictionary,NSArray,NSData或者NSNumber 这几个类的对象归档.
 
要想把自己定义的类的对象存储到文件中,
 
 你自定义的类就必须:
 
 1.遵守<NSCoding>协议
 
 2.实现: a"- (void)encodeWithCoder:(NSCoder *)enCoder"
 
 b"- (id)initWithCoder:(NSCoder *)decoder"
 
 如果有MJExtion 就直接再类的.m 内加上MJExtensionCodingImplementation
 
 例子
 
 @interface QZUser : NSObject <NSCoding>
 @property (nonatomic, copy)   NSString      *token;           // 用户ID
 @end

 @implementation QZUser
 - (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.token        forKey:@"token"];
 }
 
 - (id)initWithCoder:(NSCoder *)aDecoder {
     if (self = [super init]) {
        self.token          = [aDecoder decodeObjectForKey:@"token"];
     }
     return self;
 }
 @end

 */




#import <Foundation/Foundation.h>


#define UserDefaults        [NSUserDefaults standardUserDefaults]
//强制存储    [UserDefaults synchronize];

//当存储的是数组不需要分页仅
static  NSString *YKStoreFMDBNoPageStore = @"-1";

@interface YKStoreFMDB : NSObject

/**
 数据库实例化

 @return YKStoreFMDB
 */
+ (id)yk_sharedInstance;

/**
 弃用方法

 @return 实例对象
 */
-(instancetype)init __attribute__((deprecated("Use sharedInstance instead.")));


/**
 将对象存储

 @param storeObj 存储对象
 @param storePage 存储分页
 @param tableName 存储表名
 @return 更新存储成功
 */
-(BOOL)yk_storeObj:(id)storeObj page:(NSString *)storePage tableName:(NSString *)tableName;

/**
 读取对象

 @param tableName 存储表名
 @return 表中字典对象
 */
-(NSDictionary*)yk_readFMDBObjDataWithTableName:(NSString *)tableName;


/**
 更新存储对象

 @param storeObj 存储对象
 @param storePage 存储分页
 @param tableName 存储表名
 @return 更新是否成功
 */
-(BOOL)yk_updateFMDBObj:(id)storeObj  page:(NSString *)storePage tableName:(NSString *)tableName;


/**
 查询存储对象

 @param storePage 存储分页
 @param tableName 存储表名
 @return 存储对象
 */
- (id)yk_selectePage:(NSString *)storePage WithTabel:(NSString *) tableName;

/**
 删除存储对象

 @param storePage 存储分页
 @param tableName 存储表名
 @return 是否删除完成
 */
- (BOOL)yk_deletePage:(NSString *)storePage WithTabel:(NSString *) tableName;
@end
