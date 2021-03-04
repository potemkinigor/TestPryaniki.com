//
//  MainAssembly.swift
//  TestPryaniki.com
//
//  Created by User on 04.03.2021.
//

import Foundation
import UIKit

class MainAssembley: NSObject {
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        guard let view = viewController as? MainViewController else { return }
        let viewModel = MainViewModelImplementation()
        let networkRequest = NetworkRequestInmplemnentation()
        
        view.viewModel = viewModel
        viewModel.networkRequest = networkRequest
    }
    
}
