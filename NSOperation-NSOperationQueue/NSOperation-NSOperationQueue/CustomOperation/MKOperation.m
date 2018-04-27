//
//  MKOperation.m
//  NSOperation-NSOperationQueue
//
//  Created by MK on 2018/4/27.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "MKOperation.h"

@implementation MKOperation
-(void)main{
    if (!self.isCancelled) {
        NSLog(@"1Custom---%@",[NSThread currentThread]);
    }
}
@end
