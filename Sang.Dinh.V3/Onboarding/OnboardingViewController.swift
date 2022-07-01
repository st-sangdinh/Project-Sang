//
//  OnboardingViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/06/2022.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var page: UIPageControl!

    let viewModel: OnboardingViewModelTyple = OnboardingViewModel()
//    var indexNumber: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollection()
        configView()
        
        // Do any additional setup after loading the view.
    }

    func configCollection() {
        collectionView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func configView() {
        page.numberOfPages = viewModel.numberOfItemsInSection()
        collectionView.reloadData()
    }

    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        let item = sender.currentPage
        let indexPath = IndexPath(item: item, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @IBAction func skipButton(_ sender: Any) {
//        let viewController = RegistrationViewController()
//        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func nextButton(_ sender: Any) {
        guard var currentIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
        currentIndexPath.item += 1
        if currentIndexPath.item < viewModel.numberOfItemsInSection() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.collectionView.scrollToItem(at: currentIndexPath,
                                             at: .centeredHorizontally,
                                             animated: true)
            }
        }
        if  currentIndexPath.item == viewModel.numberOfItemsInSection() {
//            let viewController = RegistrationViewController()
//            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(data: viewModel.dataForItems(at: indexPath))
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) { 
        let offSet = scrollView.contentOffset.x
//        print(offSet)
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        page.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
        }
}
