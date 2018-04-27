//
//  ViewController.m
//  NSOperation-NSOperationQueue
//
//  Created by MK on 2018/4/27.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "ViewController.h"
#import "MKOperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[NSThread detachNewThreadSelector:@selector(operation) toTarget:self withObject:nil];//子线程
//    [self operation];//在主线程执行
    
    
    
    //Custiom
//    MKOperation *cusOperation = [[MKOperation alloc]init];
//    [cusOperation start];
    
//    [self addOperationWithBlockToQueue];
    [self addOperationToQueue];
}
/**
 * 使用 addOperation: 将操作加入到操作队列中
 */
- (void)addOperationToQueue {
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建操作
    // 使用 NSInvocationOperation 创建操作1
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    // 使用 NSInvocationOperation 创建操作2
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    
    // 使用 NSBlockOperation 创建操作3
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 3.使用 addOperation: 添加所有操作到队列中
    [queue addOperation:op1]; // [op1 start]
    [queue addOperation:op2]; // [op2 start]
    [queue addOperation:op3]; // [op3 start]
}
/**
 * 使用 addOperationWithBlock: 将操作加入到操作队列中
 */

- (void)addOperationWithBlockToQueue {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.使用 addOperationWithBlock: 添加操作到队列中
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}
-(void)operation{
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        //不一定是主线程，也有可能是子线程(只有一个任务时在主线程)
        NSLog(@"1---%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"2---%@",[NSThread currentThread]);//子线程
    }];
    [op addExecutionBlock:^{
        NSLog(@"3---%@",[NSThread currentThread]);//子线程
    }];
    [op addExecutionBlock:^{
        NSLog(@"4---%@",[NSThread currentThread]);//子线程
    }];
    [op addExecutionBlock:^{
        NSLog(@"5---%@",[NSThread currentThread]);//子线程
    }];
    [op addExecutionBlock:^{
        NSLog(@"6---%@",[NSThread currentThread]);//子线程
    }];
    [op start];
    
    
    //    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    //    queue.maxConcurrentOperationCount = 1;
    //    [queue addOperation:op];
}
@end
