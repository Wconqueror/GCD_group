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
    
    
    /*
     * a,b,c,d线程异步执行完成后,执行后面的e操作
     */
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, queue, ^{ /*任务a */
//        NSLog(@"任务a开始执行");
//        sleep(1.2);
//        NSLog(@"任务a完成了");
//
//        NSLog(@"我是%@线程",[NSThread currentThread]);
//
//    });
//    dispatch_group_async(group, queue, ^{ /*任务b */
//        NSLog(@"任务b开始执行");
//        sleep(5.2);
//        NSLog(@"任务b完成了");
//        NSLog(@"我是%@线程",[NSThread currentThread]);
//
//    });
//    dispatch_group_async(group, queue, ^{ /*任务c */
//        NSLog(@"任务c开始执行");
//        sleep(7.2);
//        NSLog(@"任务c完成了");
//        NSLog(@"我是%@线程",[NSThread currentThread]);
//
//    });
//    dispatch_group_async(group, queue, ^{ /*任务d */
//        NSLog(@"任务d开始执行");
//        sleep(3.2);
//        NSLog(@"任务d完成了");
//        NSLog(@"我是%@线程",[NSThread currentThread]);
//    });
//    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
//        // 在a、b、c、d异步执行完成后，会回调这里
//        NSLog(@"都完成啦");
//        NSLog(@"执行e操作");
//        NSLog(@"我是%@线程",[NSThread currentThread]);
//    });
    
    
    
    
    /*
     * 同步执行,先执行A任务,在执行B任务,再执行C任务,等待都完成后执行D
     */
    
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0,0);

    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group);
    [self requestA:^{
        NSLog(@"---A执行完成---");
        NSLog(@"我是%@线程",[NSThread currentThread]);
        dispatch_group_leave(group);
    }];

    dispatch_group_enter(group);
    [self requestB:^{
        NSLog(@"---执行B任务结束---");
        NSLog(@"我是%@线程",[NSThread currentThread]);
        dispatch_group_leave(group);
    }];

    dispatch_group_enter(group);
    [self requestC:^{
        NSLog(@"---执行C任务结束---");
        NSLog(@"我是%@线程",[NSThread currentThread]);
        dispatch_group_leave(group);
    }];

    dispatch_group_notify(group, globalQueue, ^{
        [self requestD:^{
            NSLog(@"我是%@线程",[NSThread currentThread]);
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
