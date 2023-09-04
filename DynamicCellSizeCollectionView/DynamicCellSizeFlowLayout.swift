//
//  DynamicCellSizeFlowLayout.swift
//  DynamicCellSizeCollectionView
//
//  Created by Schemalism on 2023/09/04.
//

import UIKit
class DynamicCellSizeFlowLayout: UICollectionViewFlowLayout {
    
    static let headerHeight:CGFloat = 50
    static let footerHeight:CGFloat = 50
    
    private var itemAttributesCache : Array<[UICollectionViewLayoutAttributes]> = []
    private var headerAttributesCache : Array<UICollectionViewLayoutAttributes> = []
    
    private var contentSize:CGSize = CGSize.zero
    
    
    private var sectionCount:Int?
    
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override init(){
        super.init()
        scrollDirection = UICollectionView.ScrollDirection.vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        super.prepare()
        
        guard let numberOfSections = self.collectionView?.numberOfSections else { return }
        guard let width = self.collectionView?.frame.width else { return }
        sectionCount = numberOfSections
        
        var y: CGFloat = 0
        
        for section in 0 ..< sectionCount! {
            var attributesCache : Array<UICollectionViewLayoutAttributes> = []
            guard let itemCount = self.collectionView?.numberOfItems(inSection: section) else { return }
            
            let headerRect = CGRect(x: 0, y: y, width: collectionView!.frame.width, height: DynamicCellSizeFlowLayout.headerHeight)
            let indexPath = NSIndexPath(item: -1, section: section)
            let headerAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath as IndexPath)
            headerAttribute.frame = headerRect
            headerAttributesCache.append(headerAttribute)
            
            y += DynamicCellSizeFlowLayout.headerHeight
            
            for item in 0 ..< itemCount {
                let indexPath = NSIndexPath(item: item, section: section)
                var itemRect : CGRect!
                
                let itemRemainder = item % 9
                
                switch itemRemainder {
                case 0 :
                    itemRect = CGRect(x: 0, y: y, width: width/3*2, height: width/3*2)
                    y += width/3*2
                case 1 :
                    itemRect = CGRect(x: width/3*2, y: y-width/3*2, width: width/3, height: width/3)
                case 2 :
                    itemRect = CGRect(x: width/3*2, y: y-width/3, width: width/3, height: width/3)
                case 3 :
                    itemRect = CGRect(x: 0, y: y, width: width/3, height: width/3)
                    y += width/3
                case 4 :
                    itemRect = CGRect(x: width/3, y: y-width/3, width: width/3, height: width/3)
                case 5 :
                    itemRect = CGRect(x: width/3*2, y: y-width/3, width: width/3, height: width/3)
                case 6 :
                    itemRect = CGRect(x: 0, y: y, width: width/3, height: width/3)
                    y += width/3
                case 7 :
                    itemRect = CGRect(x: 0, y: y, width: width/3, height: width/3)
                    y += width/3
                case 8 :
                    itemRect = CGRect(x: width/3, y: y-width/3*2, width: width/3*2, height: width/3*2)
                default :
                    itemRect = CGRect.zero
                }

                let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                itemAttributes.frame = itemRect
                attributesCache.append(itemAttributes)
                
            }
            
            itemAttributesCache.append(attributesCache)
            
        }
        contentSize = CGSize(width: (collectionView?.frame.size.width)!, height: y)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var itemAttributes = [UICollectionViewLayoutAttributes]()
        for section in 0 ..< sectionCount! {
            let numberOfItems:NSInteger = (self.collectionView?.numberOfItems(inSection: section))!
            itemAttributes.append(contentsOf: itemAttributesCache[section].filter {
                $0.frame.intersects(rect) && $0.indexPath.row < numberOfItems
            })
            if headerAttributesCache[section].frame.intersects(rect){
                itemAttributes.append(headerAttributesCache[section])
            }
        }
        return itemAttributes
    }
    
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return headerAttributesCache.first{
            $0.indexPath.section == indexPath.section && elementKind == UICollectionView.elementKindSectionHeader
        }
    }
}
