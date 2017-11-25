//
//  FruitViewerExceptionHandler.m
//  FruitViewer
//
//  Created by John, Melvin (Associate Software Developer) on 25/11/2017.
//  Copyright © 2017 John, Melvin (Associate Software Developer). All rights reserved.
//

#import "FruitViewerExceptionHandler.h"
#import "FruitViewer-Swift.h"

volatile void exceptionHandler(NSException *exception) {
    [UsageStatsErrorNotifier notifyException:exception];
}

NSUncaughtExceptionHandler *exceptionHandlerPointer = &exceptionHandler;

