//
//  CollectionViewDelegateTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class CollectionViewDelegateTests: XCTestCase {
    
    var fruitListViewController: FruitListViewController!
    var presenter: FruitListPresenter!
    var interactor: FruitListInteractor!
    
    var delegate: CollectionViewDelegate!
    
    var collectionView: UICollectionView!
    
    override func setUp() {
        super.setUp()
        
        fruitListViewController = MockFruitListViewController()
        interactor = FruitListInteractor() { completion in
            throw NetworkServiceError.noConnection
        }
        
        presenter = FruitListPresenter(viewController: fruitListViewController, interactor: interactor)
        
        fruitListViewController.presenter = presenter
        
        delegate = CollectionViewDelegate()
        
        delegate.viewController = fruitListViewController
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewLayout())
        
    }
    
    override func tearDown() {
        fruitListViewController = nil
        presenter = nil
        interactor = nil
        
        delegate = nil
        
        super.tearDown()
    }
    
    func testMinimumInteritemSpacingForSection() {
        let actualResult = delegate.collectionView(collectionView, layout: UICollectionViewLayout(), minimumInteritemSpacingForSectionAt: 0)
        
        let expectedResult: CGFloat = 0
        
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func testMinimumLineSpacingForSection() {
        let actualResult = delegate.collectionView(collectionView, layout: UICollectionViewLayout(), minimumLineSpacingForSectionAt: 0)
        
        let expectedResult: CGFloat = 4
        
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func testInsetForSection() {
        let actualResult = delegate.collectionView(collectionView, layout: UICollectionViewLayout(), insetForSectionAt: 0)
        
        let expectedResult = UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4)
        
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func testSizeForItemWithNegativeAvailableContentWidth() {
        
        delegate.viewController.view.frame = .zero
        
        let actualResult = delegate.collectionView(collectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(row: 0, section: 0))
        
        let expectedResult: CGSize = .zero
        
        XCTAssertEqual(actualResult, expectedResult)
    }
    
    func testSizeForItemWithDeviceOrientationSetToLandscape() {
        
        delegate.viewController.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let device = UIDeviceMock()
        device.customOrientation = .landscapeLeft
        
        delegate.device = device
        
        let actualResult = delegate.collectionView(collectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(row: 0, section: 0))
        
        let availableContentWidth = 100 - (4 + 4 + 4)
        
        let expectedResult: CGSize = CGSize(width: availableContentWidth/3, height: availableContentWidth/3)
        
        XCTAssertEqual(round(actualResult.width), round(expectedResult.width))
        XCTAssertEqual(round(actualResult.height), round(expectedResult.height))

    }
    
    func testSizeForItemWithDeviceOrientationSetToPortrait() {
        
        delegate.viewController.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let device = UIDeviceMock()
        
        delegate.device = device
        
        let actualResult = delegate.collectionView(collectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(row: 0, section: 0))
        
        let availableContentWidth = 100 - (4 + 4 + 4)
        
        let expectedResult: CGSize = CGSize(width: availableContentWidth/2, height: availableContentWidth/2)
        
        XCTAssertEqual(round(actualResult.width), round(expectedResult.width))
        XCTAssertEqual(round(actualResult.height), round(expectedResult.height))
        
    }
    
    func testDidSelectItemWithIndexPathRowLessThanFruitViewModelsCount() {
        
        let mockFruit = Fruit(price: 123, type: .apple, weight: 123, image: nil, name: "apple")
        
        let fruitViewModel = FruitViewModel(fruit: mockFruit)
        
        presenter.fruitViewModels = [fruitViewModel]
        
        let onPushViewControllerToNavigationController = expectation(description: " - pushViewControllerToNavigationController")
        onPushViewControllerToNavigationController.isInverted = true
        fruitListViewController.pushViewControllerToNavigationController = { navigationController in
            return { detailedPhotoViewController, animated in
                onPushViewControllerToNavigationController.fulfill()
            }
        }
        
        delegate.collectionView(collectionView, didSelectItemAt: IndexPath(row: 5, section: 0))

        waitForExpectations(timeout: 1)
    }
    
    func testDidSelectItemWithNoNavigationController() {
        
        let mockFruit = Fruit(price: 123, type: .apple, weight: 123, image: nil, name: "apple")
        
        let fruitViewModel = FruitViewModel(fruit: mockFruit)
        
        presenter.fruitViewModels = [fruitViewModel]
        
        let onPushViewControllerToNavigationController = expectation(description: " - pushViewControllerToNavigationController")
        onPushViewControllerToNavigationController.isInverted = true
        fruitListViewController.pushViewControllerToNavigationController = { navigationController in
            return { detailedPhotoViewController, animated in
                onPushViewControllerToNavigationController.fulfill()
            }
        }

        delegate.collectionView(collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        
        waitForExpectations(timeout: 1)
    }
    
    func testDidSelectItem() {
        
        let mockFruit = Fruit(price: 123, type: .apple, weight: 123, image: nil, name: "apple")
        
        let fruitViewModel = FruitViewModel(fruit: mockFruit)
        
        presenter.fruitViewModels = [fruitViewModel]
        
        let onPushViewControllerToNavigationController = expectation(description: " - pushViewControllerToNavigationController")
        fruitListViewController.pushViewControllerToNavigationController = { navigationController in
            return { detailedViewerViewController, animated in
                XCTAssertTrue(animated)
                
                guard let viewController = detailedViewerViewController as? DetailedViewerViewController else {
                    XCTFail()
                    return
                }
                
                XCTAssertNotNil(viewController.userInitiatedDate)
                
                onPushViewControllerToNavigationController.fulfill()
            }
        }
        
        let mockFruitListViewController = delegate.viewController as? MockFruitListViewController
        mockFruitListViewController?.mockNavigationController = UINavigationController()
        
        delegate.collectionView(collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        
        waitForExpectations(timeout: 1)
    }
    
}

extension CollectionViewDelegateTests {
    
    class UIDeviceMock: UIDevice {

        var customOrientation = UIDeviceOrientation.portrait
        
        override var orientation: UIDeviceOrientation {
            return customOrientation
        }
    }
    
    class MockFruitListViewController: FruitListViewController {
        
        var mockNavigationController: UINavigationController?
        
        override func viewDidLoad() {
            
        }
        
        override var navigationController: UINavigationController? {
            return mockNavigationController
        }
    }
}
