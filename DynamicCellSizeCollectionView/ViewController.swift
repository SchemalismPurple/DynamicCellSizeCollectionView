//
//  ViewController.swift
//  DynamicCellSizeCollectionView
//
//  Created by Schemalism on 2023/09/04.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
    let sampleImgs = [
        UIImage(named: "Sample0"),
        UIImage(named: "Sample1"),
        UIImage(named: "Sample2"),
        UIImage(named: "Sample3"),
        UIImage(named: "Sample4"),
        UIImage(named: "Sample5"),
        UIImage(named: "Sample6"),
        UIImage(named: "Sample7"),
        UIImage(named: "Sample8")
    ]
    
    
    lazy var layout = DynamicCellSizeFlowLayout()
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout).then{
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = false
        $0.clipsToBounds = true
        $0.backgroundColor = .white
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    private func configureUI(){
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "FeedCell")
        collectionView.register(FeedHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FeedHeader")
    }

}

extension ViewController: UICollectionViewDelegate{
    
}
extension ViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleImgs.count * Int.random(in: 1...3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let imgFilename = "Sample\(indexPath.row%9)"
        cell.imgView.image = UIImage(named: imgFilename)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FeedHeader", for: indexPath) as! FeedHeader
        header.headerLabel.text = "Header - \(indexPath.section)"
        return header
    }
    
    
    
    
}
