//
//  ReloadView.swift
//  SLYMList
//
//  Created by Dmitriy Kudrin on 09.07.2018.
//  Copyright © 2018 Dmitriy Kudrin. All rights reserved.
//

import UIKit

protocol ReloadView {
    func startLoading()
    func stopLoading()
}

class ReloadBarButtonItem: UIBarButtonItem, ReloadView {
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }
    
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
}
