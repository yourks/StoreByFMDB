//
//  Person.m
//  YKStroreFMDB
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 YoursKing. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name        forKey:@"name"];
    [aCoder encodeObject:self.num         forKey:@"num"];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name          = [aDecoder decodeObjectForKey:@"name"];
        self.num          = [aDecoder decodeObjectForKey:@"num"];
    }
    return self;
}
@end
