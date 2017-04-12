//
//  Person.h
//  YKStroreFMDB
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 YoursKing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *num;
@end
