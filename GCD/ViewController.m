//
//  ViewController.m
//  GCD
//
//  Created by 王得胜 on 2018/11/23.
//  Copyright © 2018 com.youqii.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0,0);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self requestA:^{
        NSLog(@"---A执行完成---");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self requestB:^{
        NSLog(@"---执行B任务结束---");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self requestC:^{
        NSLog(@"---执行C任务结束---");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, globalQueue, ^{
        [self requestD:^{
            NSLog(@"---执行D任务结束---");
        }];
    });
}
- (void)requestA:(void(^)(void))block{
    NSLog(@"---执行A任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

- (void)requestB:(void(^)(void))block{
    NSLog(@"---执行B任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

- (void)requestC:(void(^)(void))block{
    NSLog(@"---执行C任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
- (void)requestD:(void(^)(void))block{
    NSLog(@"---执行D任务开始---");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}



@end
