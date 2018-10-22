//
//  _NSObjectProxy.m
//  SplittableViewKit
//
//  Created by marty-suzuki on 2018/10/22.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

#import "_NSObjectProxy.h"

@implementation _NSObjectProxy

//- (BOOL)respondsToSelector:(SEL)aSelector {
//    if ([self respondsToSelector:aSelector]) {
//        return YES;
//    } else if (self._object != nil && [self._object respondsToSelector:aSelector]) {
//        return YES;
//    }
//    return NO;
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        return [self methodSignatureForSelector:aSelector];
    } else if (self._object != nil && [self._object respondsToSelector:aSelector]) {
        return [self._object methodSignatureForSelector:aSelector];
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self];
    } else if (self._object != nil && [self._object respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self._object];
    }
}

@end
