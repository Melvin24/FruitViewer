//
//  AppDelegate.swift
//  FruitViewer

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var usageStatsHandler: UsageStatsHandler!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        usageStatsHandler = UsageStatsHandler.shared
        
        usageStatsHandler.activate()
        
        NSSetUncaughtExceptionHandler(exceptionHandlerPointer)
        
        let mainWindow = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = UIStoryboard.instantiateViewControllerFromStoryboard(withName: MainViewController.Storyboard.name)
        let navigationCoordinator = MainNavigationCoordinator()
        
        try? navigationCoordinator.prepareForNavigation(source: window, destination: mainViewController, userInfo: nil)
        
        window = mainWindow
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        
        return true
        
    }

}

