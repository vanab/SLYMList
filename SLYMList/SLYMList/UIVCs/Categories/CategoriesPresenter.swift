//
//  CategoriesPresenter.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation

protocol CategoriesView: class {
    func startFetching()
    func endFetching()
    func refreshCategoriesView()
    func displayCategoriesRetrievalError(title: String, message: String)
}

protocol CategoryCellView {
    func display(title: String)
    func display(level: Int)
}

protocol CategoryPresenter {
    var numberOfCategories: Int { get }
    var router: CategoriesViewRouter { get }
    func loadData()
    func configure(cell: CategoryCellView, forRow row: Int)
}

class CategoryPresenterImpl: CategoryPresenter {
    fileprivate weak var view: CategoriesView?
    fileprivate let displayCategoriesUseCase: DisplayCategoriesUseCase
    
    let router: CategoriesViewRouter
    
    var categories = [CategoryLeveled]()
    var numberOfCategories: Int {
        return categories.count
    }
    
    init(view: CategoriesView,
         displayCategoriesUseCase: DisplayCategoriesUseCase,
         router: CategoriesViewRouter) {
        self.view = view
        self.displayCategoriesUseCase = displayCategoriesUseCase
        self.router = router
    }
    
    func loadData() {
        view?.startFetching()
        self.displayCategoriesUseCase.displayCategories { (res) in
            switch res {
            case .success(let categories):
                self.handleCategoriesReceived(categories)
            case .failure(let err):
                self.handleCategoriesError(err)
            }
            self.view?.endFetching()
        }
    }
    
    func configure(cell: CategoryCellView, forRow row: Int) {
        let category = categories[row]
        cell.display(level: category.level)
        cell.display(title: category.title)
    }
    
    // MARK: - Private
    
    fileprivate func handleCategoriesReceived(_ categories: [Category]) {
        self.categories = categoriesToLeveled(categories: categories)
        view?.refreshCategoriesView()
    }
    
    fileprivate func handleCategoriesError(_ error: Error) {
        view?.displayCategoriesRetrievalError(title: "Error", message: error.localizedDescription)
    }
    
    func categoriesToLeveled(categories: [Category]) -> [CategoryLeveled] {
        var catsLeveled = [CategoryLeveled]()
        categories.forEach { (category) in
            let rootCategoryLeveled = CategoryLeveled(title: category.title, level: 1)
            catsLeveled.append(rootCategoryLeveled)
            let subCatsLeveled = subCategories(category,
                                               level: 2)
            catsLeveled.append(contentsOf: subCatsLeveled)
        }
        return catsLeveled
    }
    
    func subCategories(_ category: Category, level: Int) -> [CategoryLeveled]{
        var cats = [CategoryLeveled]()
        for sub in category.subs {
            let categoryLeveled = CategoryLeveled(title: sub.title, level: level)
            cats.append(categoryLeveled)
            let subCatsLeveled = subCategories(sub,
                                               level: level + 1)
            cats.append(contentsOf: subCatsLeveled)
        }
        return cats
    }
    
}






