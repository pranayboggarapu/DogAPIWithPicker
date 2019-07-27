//
//  AllBreeds_MyOwn.swift
//  DogAPI
//
//  Created by Pranay Boggarapu on 7/27/19.
//  Copyright © 2019 com.udacity. All rights reserved.
//

import Foundation
import UIKit


class AllBreeds_MyOwn: ViewController {
    
    var allBreedsData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("All Breeds My own launched")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissWindow))
        navigationItem.rightBarButtonItem?.isEnabled = true
        addPickerView()
        displayAllBreedsInAPicker()
    }
    
    @objc func dismissWindow() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addPickerView() {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .yellow
        view.addSubview(pickerView)
        pickerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        pickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        pickerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        pickerView.delegate = self
        
    }
    
    @objc func displayAllBreedsInAPicker() {
        let allBreedsEndPoint = DogAPI.EndPoint.displayAllBreeds_MyOwn
        DogAPI.grabAllBreeds(allBreedsEndPoint.url, completionHandler: putDataInPicker)
    }
    
//    func grabAllBreeds(_ breedsURL: URL?, _ error: Error?) {
//        DogAPI.grabAllBreeds(breedsURL, completionHandler: <#T##([String]?, Error?) -> Void#>)
//    }
    
    
    func putDataInPicker(_ data: [String]?, _ error: Error?) {
        guard let data = data else {
            print(error)
            return
            
        }
        allBreedsData = data
        print(allBreedsData)
    }
    
    
    
}

extension AllBreeds_MyOwn: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allBreedsData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allBreedsData[row]
    }
}
