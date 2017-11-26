//
//  FruitViewerExceptionHandler.m
//  FruitViewer

#import "FruitViewerExceptionHandler.h"
#import "FruitViewer-Swift.h"

volatile void exceptionHandler(NSException *exception) {
    [UsageStatsErrorNotifier notifyException:exception notificationCenter:[NSNotificationCenter defaultCenter]];
}

NSUncaughtExceptionHandler *exceptionHandlerPointer = &exceptionHandler;

