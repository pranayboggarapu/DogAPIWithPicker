//
//  DogAPI.swift
//  DogAPI
//
//  Created by Pranay Boggarapu on 7/23/19.
//  Copyright © 2019 com.udacity. All rights reserved.
//

import Foundation
import UIKit


class DogAPI {
    
    enum EndPoint: String {
        
        case displaySingleRandomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        case displayAllBreeds_MyOwn = "https://dog.ceo/api/breeds/list/all"
        var url: URL {
            return URL(string: self.rawValue)!
        }
        
    }
    
    class func handleImageDownload(_ dogURL: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
        let anothertask = URLSession.shared.dataTask(with: dogURL, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            completionHandler(UIImage(data: data), nil)
        })
        anothertask.resume()
    }
    
    
    class func grabRandomImageURL(_ endPointURL: URL, completionHandler: @escaping (URL?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: endPointURL) { (data, response, error) in
            guard var data = data else {return}
            do {
                let decoder = JSONDecoder()
                let dogData = try decoder.decode(DogData.self, from: data)
                let dogURL = URL(string: dogData.message)!
                completionHandler(dogURL, nil)
            } catch {
                print(error)
                completionHandler(nil, error)
            }
        }
        
        task.resume()
    }
    
    
    class func grabAllBreeds(_ endPointURL: URL, completionHandler: @escaping ([String]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: endPointURL) { (data, response, error) in
            guard var data = data else {return}
            do {
                let decoder = JSONDecoder()
                let allBreedsData = try decoder.decode(DogBreedData_MyOwn.self, from: data)
                completionHandler(Array<String>(allBreedsData.message.keys), nil)
            } catch {
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
}
