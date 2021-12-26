//
//  BBImageSliderCollectionView.swift
//  
//
//  Created by Batuhan Baran on 24.12.2021.
//


import UIKit

@IBDesignable
open class BBImageSliderCollectionView: UIView {
    
    // MARK:- IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        }
    }
    @IBOutlet private weak var pageController: UIPageControl!
    
    public var imageUrls: [String] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        let bundle = Bundle.module
        let nib = UINib(nibName: "BBImageSliderCollectionView", bundle: bundle)
        if let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            nibView.frame = self.bounds
            self.addSubview(nibView)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension BBImageSliderCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: imageUrls[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
}
