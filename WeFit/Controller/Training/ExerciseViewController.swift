//
//  TrainingViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit


class ExerciseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Properties
    
    var collectionView: UICollectionView?
    let cellSpacing: CGFloat = 16
    let cellId = "ExerciseCell"
    
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
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cellSpacing)
        collectionViewFlowLayout.minimumInteritemSpacing = cellSpacing
        collectionViewFlowLayout.minimumLineSpacing = cellSpacing
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let iv:UIImageView
        if(indexPath.row == 0){
            iv = UIImageView(image: #imageLiteral(resourceName: "Component 5"))
        }else if(indexPath.row == 1){
            iv = UIImageView(image: #imageLiteral(resourceName: "Component 6"))
        } else if(indexPath.row == 2){
            iv = UIImageView(image: #imageLiteral(resourceName: "Component 7"))
        } else {
            iv = UIImageView(image: #imageLiteral(resourceName: "Component 8"))
        }
        iv.contentMode = .scaleAspectFill
        cell.addSubview(iv)
        iv.fillSuperview()
        return cell
    }
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * cellSpacing) / 2
        return CGSize(width: width, height: 174)
    }
}
