//
//  ScreenshotsCell.swift
//  AppStore
//
//  Created by Justin Seymour on 2017/12/19.
//  Copyright © 2017 Justin Seymour. All rights reserved.
//

import UIKit

class ScreenshotsCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var app: App? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
       return cv
    }()
    
    fileprivate let cellId = "cellId"
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        collectionView.delegate  = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        addSubview(dividerLineView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("H:|-14-[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:|[v0][v1(1)]|", views: collectionView, dividerLineView)
        
        collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = app?.screenshots?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotImageCell
        
        if let imageName = app?.screenshots?[indexPath.item] {
            cell.imageView.image = UIImage(named: imageName)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    private class ScreenshotImageCell: BaseCell {
        
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            return iv
        }()
        override func setUpViews() {
            super.setUpViews()
            
            layer.masksToBounds = true
            
            addSubview(imageView)
            addConstraintsWithFormat("H:|[v0]|", views: imageView)
            addConstraintsWithFormat("V:|[v0]|", views: imageView)
        }
    }
    
}
