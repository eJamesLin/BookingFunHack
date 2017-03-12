//
//  StartViewController.swift
//  HackathonForBooking
//
//  Created by CJ Lin on 2017/3/11.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    let contentView = UIView()

    lazy var bestCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.tag = 0
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return collectionView
    }()

    lazy var nearbyCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.tag = 1
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return collectionView
    }()

    fileprivate let reuseIdentifier = "reuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleView = UINib(nibName: "NavigationTitleView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView
        navigationItem.titleView = titleView

        let barButtonItem = UIBarButtonItem(title: "New", style: .done, target: self, action: #selector(giveUpTasks))
        barButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = barButtonItem

        //
        bestCollectionView.register(UINib(nibName: ChallengeCollectionViewCell.className(), bundle:nil),
                                    forCellWithReuseIdentifier: reuseIdentifier)
        nearbyCollectionView.register(UINib(nibName: ChallengeCollectionViewCell.className(), bundle:nil),
                                    forCellWithReuseIdentifier: reuseIdentifier)
        bestCollectionView.delegate = self
        bestCollectionView.dataSource = self
        nearbyCollectionView.delegate = self
        nearbyCollectionView.dataSource = self

        setupElements()
    }

    fileprivate func setupElements() {

        bestCollectionView.backgroundColor = UIColor.white
        nearbyCollectionView.backgroundColor = UIColor.white

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }

        setupContentViewElements()
    }

    func setupContentViewElements() {
        let bestLabel = UILabel()
        bestLabel.text = "精選挑戰"
        bestLabel.textColor = UIColor.gray

        let nearbyLabel = UILabel()
        nearbyLabel.text = "與您最近的挑戰"
        nearbyLabel.textColor = UIColor.gray

        contentView.addSubview(bestLabel)
        bestLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(25)
            make.top.equalTo(18)
            make.leading.equalTo(25)
        }

        contentView.addSubview(bestCollectionView)
        bestCollectionView.snp.makeConstraints { (make) in
            make.height.equalTo(260)
            make.width.equalTo(view.frame.size.width)
            make.top.equalTo(bestLabel.snp.bottom).offset(20)
            make.leading.equalTo(0)
        }

        contentView.addSubview(nearbyLabel)
        nearbyLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(25)
            make.top.equalTo(bestCollectionView.snp.bottom).offset(18)
            make.leading.equalTo(25)
        }

        contentView.addSubview(nearbyCollectionView)
        nearbyCollectionView.snp.makeConstraints { (make) in
            make.height.equalTo(260)
            make.width.equalTo(view.frame.size.width)
            make.top.equalTo(nearbyLabel.snp.bottom).offset(20)
            make.leading.equalTo(0)

            // for setup horizontal constraints of contentView
            make.bottom.equalTo(0)
            make.trailing.equalTo(0)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#file) \(#function)")
    }

    func startSolvingTask() {
        let vc = TimelineTableViewController()

        // temp data, will get from user actions
        TaskSingleTon.sharedInstance.taskCategory = "Taipei"

        //
        
        _ = self.navigationController?.pushViewController(vc, animated: true)
    }

    func giveUpTasks() {
        TaskSingleTon.sharedInstance.allTasks = []
        TaskSingleTon.sharedInstance.saveTasks()
    }
}

extension StartViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let cell = cell as? ChallengeCollectionViewCell {
            // testcase image
            cell.imageView.image = UIImage(named: "city\(collectionView.tag)\(indexPath.row)");
        }
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 225, height: 260)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        startSolvingTask()
    }
}
