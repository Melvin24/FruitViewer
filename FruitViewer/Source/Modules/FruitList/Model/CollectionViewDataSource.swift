//
//  CollectionViewDataSource.swift
//  FruitViewer

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    @IBOutlet weak var viewController: FruitListViewController!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController.presenter.fruitViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = dequeueReusableCellForTypeAndIndexPath(collectionView)(FruitListCell.self, indexPath)
        
        guard let image = viewController.presenter.fruitViewModels[indexPath.row].fruitImage else {
            return cell
        }

        cell.imageView.image = image
        
        return cell
    }
    
    var dequeueReusableCellForTypeAndIndexPath: ((UICollectionView) -> (FruitListCell.Type, IndexPath) -> FruitListCell) = UICollectionView.dequeueReusableCell

}
