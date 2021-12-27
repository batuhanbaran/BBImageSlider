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
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout
            collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionViewHeighConstraint: NSLayoutConstraint!
    
    // MARK:- Constants
    private enum Constants {
        enum Height {
            static let height: CGFloat = 170
        }
    }
    
    private var imageUrls: [String] = []
    
    public var imageSliderHeight: CGFloat = 130 {
        didSet {
            for view in self.subviews {
                view.removeFromSuperview()
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        self.bounds.size.height = imageSliderHeight + 40
        guard let view = self.loadFromNib(nibName: "BBImageSliderCollectionView") else { return }
        view.frame = self.bounds
        collectionView.bounds.size.height = imageSliderHeight
        self.addSubview(view)
    }
    
    public func setImageSources(with urls: [String]) {
        self.imageUrls = urls
        self.collectionView.reloadData()
    }
}

extension BBImageSliderCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: imageUrls[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
