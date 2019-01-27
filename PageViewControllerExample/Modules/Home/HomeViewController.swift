//
//  HomeViewController.swift
//  PageViewControllerExample
//
//  Created by Çağatay Emekci on 24.01.2019.
//  Copyright © 2019 Çağatay Emekci. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    let menuBar: MenuBar = {
        let mb = MenuBar(frame: .zero)
        return mb
    }()
    
    lazy var menuModel: MenuModel = {
        var mb = MenuModel()
        mb.imageNames = ["home", "trending", "baseline_today", "account"]
        return mb
    }()
    
    var pageViewController: PageViewController? {
        didSet {
            pageViewController?.delegatePage = self
        }
    }
    
    var changePageClosure: ((Int)->())?
    
    @IBOutlet weak var menuBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuBar()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupMenuBar() {
        menuBar.menuModel = menuModel
        menuBarView.addSubview(menuBar)
        menuBar.menuBarDelegate = self
        menuBarView.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        menuBarView.addConstraintsWithFormat("V:|[v0(60)]", views: menuBar)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? PageViewController {
            self.pageViewController = pageViewController
            self.pageViewController?.homeViewC = self
        }
    }
    
    var index: Int = 0 {
        didSet {
            self.changePageClosure?(index)
        }
    }
}

extension HomeViewController:PageViewControllerDelagate{
    func changedPage(index: Int) {
        menuBar.selectedPage = index
    }
}

extension HomeViewController:MenuBarDelegate{
    func changedMenu(index: Int) {
        self.index = index
    }
}
