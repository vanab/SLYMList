//
//  CategoriesListVC.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import UIKit

class CategoriesListVC: UIViewController, CategoriesView {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var refreshButton: UIBarButtonItem!
    var configurator = CategoriesConfiguratorImpl()
    var presenter: CategoryPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(categoriesVC: self)
        presenter.loadData()
    }
    
    //MARK: - Actions
    
    @IBAction func refreshAction(_ sender: Any) {
        presenter.loadData()
    }
    
    
    //MARK: - CategoriesView
    
    func refreshCategoriesView() {
        tableView.reloadData()
    }
    
    func displayCategoriesRetrievalError(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: .cancel,
                                     handler: nil)
        alertController.addAction(okAction)
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    func startFetching() {
        refreshButton.isEnabled = false
    }
    
    func endFetching() {
        refreshButton.isEnabled = true
    }
}

//MARK: - UITableViewDataSource

extension CategoriesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell",
                                                 for: indexPath) as! CategoryTableViewCell
        presenter.configure(cell: cell,
                            forRow: indexPath.row)
        return cell
    }
}
