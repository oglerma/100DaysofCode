//
//  ViewController.swift
//  DogAPI_random
//
//  Created by Ociel Lerma on 6/15/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//




import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBAction func fetchImage(_ sender: Any) {
    }
 
    var breeds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
       
        DogAPI.requestBreedsList(completionHandler: handleBreedsListResponse(breed:error:))
    }
    
    /***************************************************
     * Handle Receiving List of Breeds
     ***************************************************/
    func handleBreedsListResponse(breed: [String], error: Error?){
        self.breeds = breed
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
    

    /***************************************************
     * Handle Random Image Response
     ***************************************************/
    func handleRandomImageResponse(imageData: DogImage?, error: Error? ){
        guard let imageURL = URL(string: imageData?.message ?? "") else {return }
        DogAPI.requestImageFile(url: imageURL,
                                completionHandler: self.handleImageFileResponse(image:error:))
    }

    /***************************************************
     * Handle Image File Response
     ***************************************************/
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row] , completionHandler: handleRandomImageResponse(imageData:error:))
    }
}

