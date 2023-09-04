//
//  FeedCell.swift
//  DynamicCellSizeCollectionView
//
//  Created by Schemalism on 2023/09/04.
//

import UIKit

class FeedCell: UICollectionViewCell{
    
    let imgView = UIImageView().then{
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        addSubview(imgView)
        imgView.snp.makeConstraints{
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
    
    
}
