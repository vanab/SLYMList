//
//  CategoriesViewRouter.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import UIKit

protocol ViewRouter {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension ViewRouter {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}

protocol CategoriesViewRouter: ViewRouter {

}

class CategoriesViewRouterImpl: CategoriesViewRouter {
    
}
