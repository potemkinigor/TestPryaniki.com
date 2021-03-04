//
//  MainViewController.swift
//  TestPryaniki.com
//
//  Created by User on 04.03.2021.
//

import UIKit
import Foundation

class MainViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var mainTableView: UITableView!
    var viewModel: MainViewModelProtocol!
    var data: MainDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
        
        self.mainTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "mainTableViewCellReusableIdentifier")
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
    }
    
    //MARK: - Actions

    @IBAction func refreshData(_ sender: Any) {
        requestData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedName = self.data.view![indexPath.row]
        let imageView = UIImageView()
        var textMessage = ""
        var details: DetailedData!
        
        data.data?.forEach({ detailedData in
            if detailedData.name == selectedName {
                details = detailedData
            }
        })
        
        textMessage = ("Имя - \(String(details.name!)), ")
        
        
        if details.data?.text != nil {
            textMessage = textMessage + ("Текст - \(String((details.data?.text)!))")
        }
        
        if details.data?.selectedId != nil {
            textMessage = textMessage + (", Выбранный ID - \(String((details.data?.selectedId)!))")
        }
        
        if details.data?.url != nil {
            textMessage = textMessage + (", URL - \(String((details.data?.url)!))")
        }
        
        if details.data?.variants != nil {
            details.data?.variants?.forEach({ variant in
                textMessage = textMessage + (", Вариант с ID \(String(describing: variant.id!)) - \(String(describing: variant.text!))")
            })
        }
        
        if details.name == "picture" && details.name != nil {
            let url = URL(string: (details.data?.url)!)
            let data = try? Data(contentsOf: url!)
            
            imageView.image = UIImage(data: data!)
            
        }
        
        let alert = UIAlertController(title: "Информация", message: "\(textMessage)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        imageView.frame = CGRect(x: alert.view.frame.origin.x, y: alert.view.frame.origin.y, width: 30, height: 30)
        imageView.contentMode = .scaleAspectFit
        
        alert.view.addSubview(imageView)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Private functions
    
    private func requestData () {
        
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            var response: MainDataModel!
            
            self.viewModel.getData { (data) in
                response = data
                
                if response == nil {
                    let alert = UIAlertController(title: "Ошибка", message: "Данне с сервера не получены", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.data = response
                    self.mainTableView.reloadData()
                }

                
            }
        }
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnedValue = 0
        
        if self.data != nil {
            returnedValue = data.view!.count
        } else {
            returnedValue = 0
        }
        
        return returnedValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "mainTableViewCellReusableIdentifier") as! MainTableViewCell
        
        cell.nameTextLabel.text = self.data.view?[indexPath.row]
        
        return cell
    }
    
}

