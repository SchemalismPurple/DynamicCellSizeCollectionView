//
//  FeedHeader.swift
//  DynamicCellSizeCollectionView
//
//  Created by Schemalism on 2023/09/04.
//

import UIKit

class FeedHeader: UICollectionReusableView {
    
    
    let headerLabel = UILabel().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor.darkGray
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview()
        }
    }
}
