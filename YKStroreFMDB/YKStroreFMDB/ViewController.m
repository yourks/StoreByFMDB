//
//  ViewController.m
//  YKStroreFMDB
//
//  Created by Apple on 17/4/7.
//  Copyright © 2017年 YoursKing. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "YKStoreFMDB/YKStoreFMDB.h"

@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *objArr;
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *redLabel = [UILabel new];
    redLabel.frame = (CGRect){0,100,100,50};
    
    redLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:redLabel];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    BOOL isStore = [[YKStoreFMDB yk_sharedInstance]yk_storeObj:self.objArr page:YKStoreFMDBNoPageStore tableName:@"textTable"];
//    NSLog(@"%hhd",isStore);
    
//    NSDictionary *dict = [[YKStoreFMDB yk_sharedInstance]yk_readFMDBObjDataWithTableName:@"textTable"];
//    NSLog(@"%@",dict);
    
//    BOOL isStore = [[YKStoreFMDB yk_sharedInstance]yk_updateFMDBObj:self.dataArr page:YKStoreFMDBNoPageStore tableName:@"textTable"];
//    NSLog(@"%hhd",isStore);
    
//    id isStore = [[YKStoreFMDB yk_sharedInstance]yk_selectePage:YKStoreFMDBNoPageStore WithTabel:@"textTable"];
//    NSLog(@"%@",isStore);
    
//    BOOL isStore = [[YKStoreFMDB yk_sharedInstance]yk_deletePage:YKStoreFMDBNoPageStore WithTabel:@"textTable"];
//    NSLog(@"%hhd",isStore);

//    Class aClass = [Person class];
//    
//    NSArray *pArr = [YKRuntimeHelper getPropertyNamesArr:aClass];
//    


//    [YKGlobe shareGlobe].isNight = YES;
    
//    YKDetailViewController *VC = [[YKDetailViewController alloc]init];
//    [self presentViewController:VC animated:YES completion:nil];
}


-(NSArray *)dataArr{
    
    return @[@"0",
             @"1",
             @"2",
             @"3",
             @"4",
             @"5",
             @"6",
             @"7",
             @"8",
             @"9",
             @"10"
            ];
}

-(NSDictionary *)dict{
    return @{@"king":@"0",
             @"king":@"1",
             @"king":@"2",
             @"king":@"3",
             @"king":@"4",
             @"king":@"5",
             @"king":@"6",
             @"king":@"7",
             @"king":@"8",
             @"king":@"9",
            };
}

-(NSMutableArray *)objArr{
    
    
    if (!_objArr) {
        
        _objArr = [NSMutableArray array];
        
        for (NSInteger i = 0; i<10; i++) {
            Person *person  = [Person new];
            person.name = @"name";
            person.num  = @"0";
            
            [_objArr  addObject:person];
            
            person.num = [NSString stringWithFormat:@"%d",[person.num integerValue] + 1];
        }
    }
    
    
    
    return _objArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
