//
//  ViewController.swift
//  DogAPI
//
//  Created by Pranay Boggarapu on 7/23/19.
//  Copyright © 2019 com.udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dogImage: UIImageView = {
        var dogImageView = UIImageView()
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        return dogImageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addNavBarButton()
        view.addSubview(dogImage)
        addImageViewConstraints()
        // Do any additional setup after loading the view, typically from a nib.
//        print("The URL is \(DogAPI.EndPoint.displaySingleRandomImageFromAllDogsCollection.url)")
//            refreshImage()
        
    }

    
    func addImageViewConstraints() {
        dogImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        dogImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 8).isActive = true
        dogImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        dogImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16).isActive = true
    }
    
    func addNavBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refreshImage))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Display All Breeds", style: .done, target: self, action: #selector(displayAllBreeds))
        
        
//        UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshImage))
        
    }
    
    @objc func displayAllBreeds() {
        let allBreedsController = AllBreeds_MyOwn()
        let navigationController = UINavigationController(rootViewController: allBreedsController)
        present(navigationController, animated: true, completion: nil)
    }
    
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
    
}

