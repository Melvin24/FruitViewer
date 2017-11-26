//
//  FruitViewerExceptionHandler.h
//  FruitViewer

#import <Foundation/Foundation.h>

volatile void exceptionHandler(NSException *exception);
extern NSUncaughtExceptionHandler *exceptionHandlerPointer;
