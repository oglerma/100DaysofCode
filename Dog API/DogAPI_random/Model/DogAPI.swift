//
//  DogAPI.swift
//  DogAPI_random
//
//  Created by Ociel Lerma on 6/15/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    // MARK: - ENDPOINTS
    private enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        private var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    
    // MARK: - REQUESTS
    /***************************************************
     *REQUEST BREED LIST
     ***************************************************/
    
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void){
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url){ data, response, error in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let breedsResponse = try decoder.decode(BreedsListResponse.self, from: data)
                let breeds = breedsResponse.message.keys.map({$0})
                completionHandler(breeds, nil)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    /***************************************************
     *REQUEST IMAGE FILE
     ***************************************************/
    
    
    /***************************************************
     *REQUEST RANDOM IMAGE
     ***************************************************/
    class func requestRandomImage(breed: String , completionHandler: @escaping (DogImage?, Error?) -> Void){
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomImageEndpoint){ data, response, error in
            guard let data = data else {
                completionHandler(nil, error)
                return }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    
    /***************************************************
     *REQUEST IMAGE FILE
     ***************************************************/
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            /***************************************************
             * If you can't get the data then we activate the completionHandler with the image as nil
             * and an error included
             ***************************************************/
            guard let data = data  else {
                completionHandler(nil, error)
                return
            }
            /***************************************************
             * If you can get the image data then we convert the data into an image type
             * and call the completion handler with an image and nil as the error value.
             ***************************************************/
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        }
        task.resume()
    }
    
    
}
