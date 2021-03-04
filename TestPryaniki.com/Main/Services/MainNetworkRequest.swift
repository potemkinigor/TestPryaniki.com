//
//  MainNetworkRequest.swift
//  TestPryaniki.com
//
//  Created by User on 04.03.2021.
//

import Foundation
import Alamofire

protocol NetworkRequestProtocol {
    func requestData (complition: @escaping (MainDataModel) -> ())
}

class NetworkRequestInmplemnentation: NetworkRequestProtocol {
    func requestData(complition: @escaping (MainDataModel) -> ()) {
        AF.request("https://pryaniky.com/static/json/sample.json")
            .validate()
            .responseDecodable(of: MainDataModel.self) { response in
                guard let data = response.value else { return }
                complition(data)
            }
    }
    
}


