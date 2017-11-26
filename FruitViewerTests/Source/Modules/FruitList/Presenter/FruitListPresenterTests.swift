//
//  FruitListPresenterTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class FruitListPresenterTests: XCTestCase {
    
    var fruitListViewController: FruitListViewController!

    var presenter: FruitListPresenter!
    var interactor: MockInteractor!
    
    
    override func setUp() {
        super.setUp()
        
        fruitListViewController = FruitListViewController()
        
        interactor = MockInteractor() { completion in
            throw NetworkServiceError.noConnection
        }
        
        presenter = FruitListPresenter(viewController: fruitListViewController, interactor: interactor)
        
        fruitListViewController.presenter = presenter
        
    }
    
    override func tearDown() {
        fruitListViewController = nil
        presenter = nil
        interactor = nil
        
        super.tearDown()
    }
    
    func testloadIfRequiredWithSuccess() {
        
        let mockFruit = Fruit(price: 123, type: .apple, weight: 123, image: nil, name: "apple")
        
        interactor.mockResult = .success([mockFruit])
        
        let onNotifyLoadUsageStatsForRequestTime = expectation(description: " - notifyLoadUsageStatsForRequestTime")
        presenter.notifyLoadUsageStatsForRequestTime = { _,_,_ in
            onNotifyLoadUsageStatsForRequestTime.fulfill()
        }
        
        let onPresenterWillUpdateContent = expectation(description: " - presenterWillUpdateContent")
        presenter.presenterWillUpdateContent = { _ in
            onPresenterWillUpdateContent.fulfill()
        }
        
        let onPresenterDidUpdateContent = expectation(description: " - presenterDidUpdateContent")
        presenter.presenterDidUpdateContent = { _ in
            onPresenterDidUpdateContent.fulfill()
        }
        
        let onPresenterDidFailWithError = expectation(description: " - PresenterDidFailWithError")
        onPresenterDidFailWithError.isInverted = true
        presenter.presenterDidFailWithError = { _, _ in
            onPresenterDidFailWithError.fulfill()
        }
        
        presenter.loadIfRequired()
        
        waitForExpectations(timeout: 1) { error in
            XCTAssertEqual(self.presenter.fruitViewModels.count, 1)
        }
    }
    
    func testloadIfRequiredWithFailiure() {
                
        interactor.mockResult = .failure(NetworkServiceError.noConnection)
        
        let onNotifyLoadUsageStatsForRequestTime = expectation(description: " - notifyLoadUsageStatsForRequestTime")
        presenter.notifyLoadUsageStatsForRequestTime = { _,_,_ in
            onNotifyLoadUsageStatsForRequestTime.fulfill()
        }
        
        let onPresenterWillUpdateContent = expectation(description: " - presenterWillUpdateContent")
        presenter.presenterWillUpdateContent = { _ in
            onPresenterWillUpdateContent.fulfill()
        }
        
        let onPresenterDidUpdateContent = expectation(description: " - presenterDidUpdateContent")
        onPresenterDidUpdateContent.isInverted = true
        presenter.presenterDidUpdateContent = { _ in
            onPresenterDidUpdateContent.fulfill()
        }
        
        let onPresenterDidFailWithError = expectation(description: " - PresenterDidFailWithError")
        presenter.presenterDidFailWithError = { _, error in
            
            if case let networkError as NetworkServiceError = error {
                switch networkError {
                case .noConnection:
                    break
                case _:
                    XCTFail()
                }
            } else {
                XCTFail()
            }
            
            onPresenterDidFailWithError.fulfill()
        }
        
        presenter.loadIfRequired()
        
        waitForExpectations(timeout: 1)
    }
    
}

extension FruitListPresenterTests {
    
    class MockInteractor: FruitListInteractor {
        
        var mockResult: Result<[Fruit]> = .success([])
        override func fetchData(completion: @escaping (Result<[Fruit]>) -> Void) {
            completion(mockResult)
        }
        
    }
}
