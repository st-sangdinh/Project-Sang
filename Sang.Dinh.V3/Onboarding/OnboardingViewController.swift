//
//  OnboardingViewController.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 28/06/2022.
//

import UIKit

final class OnboardingViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var page: UIPageControl!

    let viewModel: OnboardingViewModelTyple = OnboardingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollection()
        configView()
    }

    private func configCollection() {
        collectionView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func configView() {
        page.numberOfPages = viewModel.numberOfItemsInSection()
        collectionView.reloadData()
    }

    @IBAction private func pageControlValueChanged(_ sender: UIPageControl) {
        let item = sender.currentPage
        let indexPath = IndexPath(item: item, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @IBAction private func skipButton(_ sender: Any) {
    }

    @IBAction private func nextButton(_ sender: Any) {
        guard var currentIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
        currentIndexPath.item += 1
        if currentIndexPath.item < viewModel.numberOfItemsInSection() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.collectionView.scrollToItem(at: currentIndexPath,
                                             at: .centeredHorizontally,
                                             animated: true)
            }
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
