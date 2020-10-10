//
//  ActivityController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

class ActivityController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: - Properties
    
    var collectionView: UICollectionView?
    let cellSpacing:CGFloat = 16
    let attendenceCell = "AttendenceCell"
    let dailyCell = "DailyCell"
    let analysisCell = "AnalysisCell"
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView!)
        collectionView?.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        collectionView?.backgroundColor = .white
        
        //collectionView settings
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
        
        collectionView?.register(AttendenceContainerCell.self, forCellWithReuseIdentifier: attendenceCell)
        collectionView?.register(DailyActivityContainerCell.self, forCellWithReuseIdentifier: dailyCell)
        collectionView?.register(AnalysisContainerCell.self, forCellWithReuseIdentifier: analysisCell)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: attendenceCell, for: indexPath)
        } else if indexPath.section == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: dailyCell, for: indexPath)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: analysisCell, for: indexPath)
        }
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 188+38)
        } else if indexPath.section == 1 {
            return .init(width: view.frame.width, height: 108+34)
        } else {
            return CGSize(width: view.frame.width, height: (UIScreen.main.bounds.size.height - 5 * cellSpacing)/2)
        }
    }
}
