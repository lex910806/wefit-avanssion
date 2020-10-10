//
//  GuideViewController.swift
//  WeFit
//
//  Created by sangwon on 2020/10/09.
//

import UIKit


class GuideViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Properties
    
    var collectionView: UICollectionView?
    let cellSpacing: CGFloat = 16
    let cellId = "GuideCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView!)
        
//        collectionView?.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
//        collectionView?.constrainHeight(constant: 133)
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let iv:UIImageView
        if(indexPath.row == 0){
            iv = UIImageView(image: #imageLiteral(resourceName: "guide1"))
        }else {
            iv = UIImageView(image: #imageLiteral(resourceName: "guide2"))
        }
        iv.contentMode = .scaleAspectFill
        cell.addSubview(iv)
        iv.fillSuperview()
        return cell
    }
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 253, height: 133)
    }
}
