//
//  MainDataModel.swift
//  TestPryaniki.com
//
//  Created by User on 04.03.2021.
//

import Foundation

struct MainDataModel: Decodable {
    var data: [DetailedData]?
    var view: [String]?
}

struct DetailedData: Decodable {
    var name: String?
    var data: SectionDetails?
}

struct SectionDetails: Decodable {
    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [Variants]?
}

struct Variants: Decodable {
    var id: Int?
    var text: String?
}

