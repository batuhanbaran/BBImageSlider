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
    @IBOutlet weak var stackView: UIStackView!
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
    @IBOutlet weak var collectionViewHeighConstraint: NSLayoutConstraint!
    
    private lazy var pageController: UIPageControl = {
        let pageController = UIPageControl()
        pageController.numberOfPages = imageUrls.count
        pageController.hidesForSinglePage = true
        return pageController
    }()
    
    // MARK:- Constants
    private enum Constants {
        enum Height {
            static let height: CGFloat = 170
        }
    }
    
    // MARK:- Private Properties
    private var imageUrls: [String] = [] {
        didSet {
            pageController.numberOfPages = imageUrls.count
        }
    }
    
    private var contentOffset: CGPoint = .zero
    
    // MARK:- Public Properties
    public var imageSliderHeight: CGFloat = 130 {
        didSet {
            for view in self.subviews {
                view.removeFromSuperview()
            }
            configureView()
        }
    }
    
    public var imageContentMode: UIView.ContentMode = .scaleAspectFit
    
    public var pageIndicatorTintColor: UIColor = .white {
        didSet {
            pageController.pageIndicatorTintColor = pageIndicatorTintColor
        }
    }
    
    public var currentPageIndicatorTintColor: UIColor = .black {
        didSet {
            pageController.currentPageIndicatorTintColor = currentPageIndicatorTintColor
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
        self.bounds.size.height = imageSliderHeight + pageController.frame.height
        guard let view = self.loadFromNib(nibName: "BBImageSliderCollectionView") else { return }
        view.frame = self.bounds
        self.stackView.addArrangedSubview(pageController)
        collectionViewHeighConstraint.constant = imageSliderHeight
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
        cell.configure(with: imageUrls[indexPath.row], contentMode: imageContentMode)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.bounds.size.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageController.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
//    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if collectionView.isBouncingRight {
//            DispatchQueue.main.async {
//                self.collectionView.isPagingEnabled = false
//                self.collectionView.scrollToItem(
//                    at: IndexPath(row: 0, section: 0),
//                    at: .centeredHorizontally,
//                    animated: true
//                )
//                self.collectionView.isPagingEnabled = true
//                self.pageController.currentPage = 0
//            }
//        }
//        
//        else if collectionView.isBouncingLeft {
//            DispatchQueue.main.async {
//                self.collectionView.isPagingEnabled = false
//                self.collectionView.scrollToItem(
//                    at: IndexPath(row: (self.imageUrls.count - 1), section: 0),
//                    at: .centeredHorizontally,
//                    animated: true
//                )
//                self.collectionView.isPagingEnabled = true
//                self.pageController.currentPage = self.imageUrls.count - 1
//            }
//        }
//    }
}
