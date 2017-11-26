//
//  CollectionViewDataSourceTests.swift
//  FruitViewerTests

import XCTest
@testable import FruitViewer

class CollectionViewDataSourceTests: XCTestCase {
    
    var fruitListViewController: FruitListViewController!
    var presenter: FruitListPresenter!
    var interactor: FruitListInteractor!
    
    var dataSource: CollectionViewDataSource!
    
    var collectionView: UICollectionView!
    
    override func setUp() {
        super.setUp()
        
        fruitListViewController = FruitListViewController()
        interactor = FruitListInteractor() { completion in
            throw NetworkServiceError.noConnection
        }
        
        presenter = FruitListPresenter(viewController: fruitListViewController, interactor: interactor)
        
        fruitListViewController.presenter = presenter
        
        dataSource = CollectionViewDataSource()
        
        dataSource.viewController = fruitListViewController
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewLayout())
        
    }
    
    override func tearDown() {
        fruitListViewController = nil
        presenter = nil
        interactor = nil
        
        dataSource = nil
        
        super.tearDown()
    }
    
    func testNumberOfSectionsInCollectionView() {
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1)
    }
    
    func testCollectionViewNumberOfItemsInSection() {
        
        let mockFruit = Fruit(price: 123, type: .apple, weight: 123, image: nil, name: "apple")
        
        let fruitViewModel = FruitViewModel(fruit: mockFruit)
        
        presenter.fruitViewModels = [fruitViewModel]
        
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 1)
        
    }
    
    func testCollectionViewCellForItemWithoutImage() {
        dataSource.dequeueReusableCellForTypeAndIndexPath = { collectionView in
            return { cellType, indexPath in
                return UIView.loadViewFromNib(as: FruitListCell.self)
            }
        }
        
        let mockFruit = Fruit(price: 123, type: .apple, weight: 123, image: nil, name: "apple")
        
        let fruitViewModel = FruitViewModel(fruit: mockFruit)
        
        presenter.fruitViewModels = [fruitViewModel]

        let cell = dataSource.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        
        guard let fruitListCell = cell as? FruitListCell else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(fruitListCell.imageView.image, UIImage(named: "no_image"))
        
    }
    
    func testCollectionViewCellForItem() {
        dataSource.dequeueReusableCellForTypeAndIndexPath = { collectionView in
            return { cellType, indexPath in
                return UIView.loadViewFromNib(as: FruitListCell.self)
            }
        }
        
        let mockFruit = Fruit(price: 123, type: .apple, weight: 123, image: UIImage(named: "strawberry_image"), name: "apple")
        
        let fruitViewModel = FruitViewModel(fruit: mockFruit)
        
        presenter.fruitViewModels = [fruitViewModel]
        
        let cell = dataSource.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        
        guard let fruitListCell = cell as? FruitListCell else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(fruitListCell.imageView.image, UIImage(named: "strawberry_image"))
        
    }
}
