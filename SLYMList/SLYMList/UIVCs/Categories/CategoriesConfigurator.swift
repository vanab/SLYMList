//
//  CategoriesConfigurator.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import Foundation

protocol CategoriesConfigurator {
    func configure(categoriesVC: CategoriesListVC)
}

class CategoriesConfiguratorImpl: CategoriesConfigurator {
    func configure(categoriesVC: CategoriesListVC) {
        let apiClient = ApiClientImpl(request: CategoriesApiRequest().urlRequest)
        let apiCategoriesGateway = ApiCategoriesGatewayImpl(apiClient: apiClient)
        let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
        let coreDataCategoriesGateway = CoreDataCategoriesGateway(viewContext: viewContext)
        let categoriesGateway = FetchCategoriesGateway(apiCategoriesGateway: apiCategoriesGateway,
                                                       localPersistenceCategoriesGateway: coreDataCategoriesGateway)
        let displayCategoriesUseCase = DisplayCategoriesListUseCaseImplementation(categoriesGateway: categoriesGateway)
        let router = CategoriesViewRouterImpl() // ....
        let presenter = CategoryPresenterImpl(view: categoriesVC,
                                              displayCategoriesUseCase: displayCategoriesUseCase,
                                              router: router)
        categoriesVC.presenter = presenter
    }
}
