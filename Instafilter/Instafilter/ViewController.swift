//
//  ViewController.swift
//  Instafilter
//
//  Created by Ociel Lerma on 5/18/19.
//  Copyright © 2019 Ociel Lerma. All rights reserved.
//

import CoreImage
import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    var currentImage: UIImage!
    var context: CIContext!       // handles rendering
    var currentFilter: CIFilter!  // Store whatever filter the user has activated
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "InstaFilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        context = CIContext()
        currentFilter = CIFilter(name: FilterType.CISepiaTone.rawValue)
    }

    @objc func importPicture(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true)
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    

    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter",
                                   message: nil,
                                   preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: FilterType.CIBumpDistortion.rawValue,
                                   style: .default,
                                   handler: setFilter))
        ac.addAction(UIAlertAction(title: FilterType.CIGaussianBlur.rawValue,
                                   style: .default,
                                   handler: setFilter))
        ac.addAction(UIAlertAction(title: FilterType.CIPixellate.rawValue,
                                   style: .default,
                                   handler: setFilter))
        ac.addAction(UIAlertAction(title: FilterType.CISepiaTone.rawValue,
                                   style: .default,
                                   handler: setFilter))
        ac.addAction(UIAlertAction(title: FilterType.CITwirlDistortion.rawValue,
                                   style: .default,
                                   handler: setFilter))
        ac.addAction(UIAlertAction(title: FilterType.CIUnsharpMask.rawValue,
                                   style: .default,
                                   handler: setFilter))
        ac.addAction(UIAlertAction(title: FilterType.CIVignette.rawValue,
                                   style: .default,
                                   handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel",
                                   style: .cancel,
                                   handler: setFilter))
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        present(ac, animated: true)
        
        print(FilterType.CISepiaTone.rawValue)
    }
    
    func setFilter(action: UIAlertAction){
        guard currentImage != nil else {return}
        guard let actionTitle = action.title else {return}
        
        currentFilter = CIFilter(name: actionTitle)
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    @IBAction func save(_ sender: Any) {
        
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    
    func applyProcessing(){
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey){
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
    
    // Filter Types
    private enum FilterType: String {
        case CIBumpDistortion  = "CIBumpDistortion"
        case CIGaussianBlur    = "CIGaussianBlur"
        case CIPixellate       = "CIPixellate"
        case CISepiaTone       = "CISepiaTone"
        case CITwirlDistortion = "CITwirlDistortion"
        case CIUnsharpMask     = "CIUnsharpMask"
        case CIVignette        = "CIVignette"
    }


}


