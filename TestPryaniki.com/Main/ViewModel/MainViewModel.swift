//
//  MainViewModel.swift
//  TestPryaniki.com
//
//  Created by User on 04.03.2021.
//

import Foundation
import UIKit

protocol MainViewModelProtocol {
    func getData(complition: @escaping (MainDataModel) -> ())
}

class MainViewModelImplementation: MainViewModelProtocol {
    
    var networkRequest: NetworkRequestProtocol!
    
    func getData(complition: @escaping (MainDataModel) -> ()) {
        self.networkRequest.requestData { data in
            complition(data)
        }
    }
    
}
