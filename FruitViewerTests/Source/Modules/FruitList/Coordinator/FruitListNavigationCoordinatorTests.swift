//
//  FruitListNavigationCoordinatorTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class FruitListNavigationCoordinatorTests: XCTestCase {
    
    func testPrepareForNavigationWithInvalidDestination() {
        
        let destination = UIViewController()
        
        let navigationCoordinator = FruitListNavigationCoordinator()
        
        do  {
            try navigationCoordinator.prepareForNavigation(source: UIViewController(), destination: destination, userInfo: nil)
        } catch let error as CoordinateError {
            switch error {
            case .unsupported(let reason):
                XCTAssertEqual(reason, "Coordination not supported")
            }
        } catch {
            XCTFail()
        }
        
    }
    
    func testPrepareForNavigation() {
        
        let fruitListViewController = FruitListViewController()
        
        let navigationController = MockNavigationController()
        
        navigationController.mockTopNavigationController = fruitListViewController
        
        let navigationCoordinator = FruitListNavigationCoordinator()
        
        do  {
            try navigationCoordinator.prepareForNavigation(source: UIViewController(), destination: navigationController, userInfo: nil)
            
            XCTAssertNotNil(fruitListViewController.presenter)
            
        } catch let error as CoordinateError {
            switch error {
            case .unsupported(let reason):
                XCTAssertEqual(reason, "Coordination not supported")
            }
        } catch {
            XCTFail()
        }
        
    }
    
}

extension FruitListNavigationCoordinatorTests {
    
    class MockNavigationController: UINavigationController {
        
        var mockTopNavigationController: UIViewController?
        
        override var topViewController: UIViewController? {
            return mockTopNavigationController
        }
        
    }
    
}
