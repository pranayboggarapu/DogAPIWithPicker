//
//  ViewController.swift
//  DogAPI
//
//  Created by Pranay Boggarapu on 7/23/19.
//  Copyright © 2019 com.udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dogBreedsData: [String] = []
    
    var dogImage: UIImageView = {
        var dogImageView = UIImageView()
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        return dogImageView
    }()
    
    var dogpickerView: UIPickerView = {
        var dogPicker = UIPickerView()
        dogPicker.translatesAutoresizingMaskIntoConstraints = false
        return dogPicker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addNavBarButton()
        view.addSubview(dogImage)
        view.addSubview(dogpickerView)
        addImageViewConstraints()
        addPickerViewConstraints()
        dogpickerView.delegate = self
        displayAllBreedsInAPicker()
        // Do any additional setup after loading the view, typically from a nib.
//        print("The URL is \(DogAPI.EndPoint.displaySingleRandomImageFromAllDogsCollection.url)")
//            refreshImage()
        
    }
    
    func addPickerViewConstraints() {
        dogpickerView.backgroundColor = .yellow
        dogpickerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dogpickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        dogpickerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dogpickerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    
    func addImageViewConstraints() {
        dogImage.contentMode = .scaleAspectFit
        dogImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        dogImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        dogImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
        dogImage.heightAnchor.constraint(equalToConstant: 550).isActive = true
    }
    
    func addNavBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refreshImage))
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Display All Breeds", style: .done, target: self, action: #selector(displayAllBreeds))
        
        
//        UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshImage))
        
    }
    
//    @objc func displayAllBreeds() {
//        let allBreedsController = AllBreeds_MyOwn()
//        let navigationController = UINavigationController(rootViewController: allBreedsController)
//        present(navigationController, animated: true, completion: nil)
//    }
    
    @objc func refreshImage() {
        let randomImageEndPoint = DogAPI.EndPoint.displaySingleRandomImageFromAllDogsCollection.url
        DogAPI.grabRandomImageURL(randomImageEndPoint, completionHandler: grabImageURL)
//        DogAPI.grabRandomImageURL(randomImageEndPoint) { (dogURL, error) in
//              DogAPI.handleImageDownload(dogURL ?? URL(string: "")!, completionHandler: self.handleUIImage(image:error:))
//        }
        
        
//        let task = URLSession.shared.dataTask(with: randomImageEndPoint) { (data, response, error) in
//            guard var data = data else {return}
//            do {
//                //                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                //                print(jsonObject["message"] as! String)
//
//                let decoder = JSONDecoder()
//                let dogData = try decoder.decode(DogData.self, from: data)
//                let dogURL = URL(string: dogData.message)!
//
////                DogAPI.handleImageDownload(dogURL, completionHandler: { (image, error) in
////                    DispatchQueue.main.async {
////                        self.imageView.image = image
////                    }
////                })
//
//                DogAPI.handleImageDownload(dogURL, completionHandler: self.handleUIImage(image:error:))
//
//
////                let anothertask = URLSession.shared.dataTask(with: dogURL, completionHandler: { (data, response, error) in
////                    guard let data = data else {return}
//////                    DispatchQueue.main.async {
//////                        self.imageView.image = UIImage(data: data)
//////                    }
////                })
//
////                anothertask.resume()
//            } catch {
//                print(error)
//            }
//        }
//
//        task.resume()
    }

    func handleUIImage(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.dogImage.image = image
        }
    }
    
    func grabImageURL(dogURL: URL?, error: Error?) {
        DogAPI.handleImageDownload(dogURL ?? URL(string: "")!, completionHandler: self.handleUIImage(image:error:))
    }
    
    @objc func displayAllBreedsInAPicker() {
        let allBreedsEndPoint = DogAPI.EndPoint.displayAllBreeds_MyOwn
        DogAPI.grabAllBreeds(allBreedsEndPoint.url, completionHandler: putDataInPicker)
    }
    
    func putDataInPicker(_ data: [String]?, _ error: Error?) {
        guard let data = data else {
            print(error)
            return
            
        }
        dogBreedsData = data
        DispatchQueue.main.async {
            self.dogpickerView.reloadAllComponents()
        }
    }
    
}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dogBreedsData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String{
        return dogBreedsData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected the row \(pickerView.selectedRow(inComponent: component))")
        let rowDataSelected = dogBreedsData[pickerView.selectedRow(inComponent: component)]
        print(rowDataSelected)
        let selectedBreedCustomURL: URL = URL(string: DogAPI.EndPoint.displayRandomImage_PerBreed(breedValue: rowDataSelected).stringValue)!
        print(selectedBreedCustomURL)
        DogAPI.gradRandomImageByBreed(selectedBreedCustomURL, completionHandler: grabImageURL(dogURL:error:))
        
    }
    
}

