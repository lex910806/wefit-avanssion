//
//  TrainingViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit


class DailyActivityController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Properties
    
    var collectionView: UICollectionView?
    let cellSpacing: CGFloat = 16
    let cellId = "DailyActivity"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView!)
        collectionView?.fillSuperview()
        collectionView?.backgroundColor = .white
        
        //collectionView settings
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cellSpacing)
        collectionViewFlowLayout.minimumInteritemSpacing = cellSpacing
        collectionViewFlowLayout.minimumLineSpacing = cellSpacing
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let iv:UIImageView
        if(indexPath.row == 0){
            iv = UIImageView(image: #imageLiteral(resourceName: "daily1"))
        }else if(indexPath.row == 1){
            iv = UIImageView(image: #imageLiteral(resourceName: "daily2"))
        } else {
            iv = UIImageView(image: #imageLiteral(resourceName: "daily3"))
        }
        iv.contentMode = .scaleAspectFill
        cell.addSubview(iv)
        iv.fillSuperview()
        
        return cell
    }
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104, height: 108)
    }
}

