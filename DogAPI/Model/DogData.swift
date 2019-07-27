//
//  DogData.swift
//  DogAPI
//
//  Created by Pranay Boggarapu on 7/23/19.
//  Copyright © 2019 com.udacity. All rights reserved.
//

import Foundation

struct DogData: Codable {
    var message: String
    var status: String
}


struct DogBreedData_MyOwn: Codable {
    var message: [String: [String]]
    var status: String
}
