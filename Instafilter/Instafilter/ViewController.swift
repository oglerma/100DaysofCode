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
    @IBOutlet var filterNameLbl: UILabel!
    @IBOutlet var radiusSlider: UISlider!
    @IBOutlet var radiusLabel: UILabel!
    var currentImage: UIImage!
    var context: CIContext!       // handles rendering
    var currentFilter: CIFilter!{
        didSet{
            filterNameLbl.text = currentFilter.name
        }
    } // Store whatever filter the user has activated
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "InstaFilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        context = CIContext()
        currentFilter = CIFilter(name: FilterType.CIVignette.rawValue)
    }

    /*****************************************************
    * Called before the image is added to the view.
    * Basically it is saying that this function is promosing to do what
    * is inside of the function earlier than expected. So before going back to
    * our viewController, this function is being invoved.
    ******************************************************/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.alpha = 0
    }
    
    
    /***************************************************
     * it basically means that this is being called when the screen is
     * shown to the user. The difference between viewDidAppear and
     * viewDidLoad is that viewDidAppear is called every time you land on
     * the screen while viewDidLoad is only called once which is
     * when the app loads.
     // Called after the image is added to the view.
     ***************************************************/

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2) {
            self.imageView.alpha = 1
        }
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
    }
    
    func setFilter(action: UIAlertAction){
        guard currentImage != nil else {return}
        guard let actionTitle = action.title else {return}

        currentFilter = CIFilter(name: actionTitle)
        print("Inside Set Filter with:  \(currentFilter.name)")
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else {
            showAlertWithNoImageSaved()
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavinWithError:contextInfo:)), nil)
    }
    
    func showAlertWithNoImageSaved(){
        let ac = UIAlertController(title: "There is no image to save. ", message: "Please upload image", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    @IBAction func radiusChanged(_ sender: Any) {
        applyProcessing()
    }
    
    func applyProcessing(){
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputRadiusKey){
            radiusLabel.isHidden = false
            radiusSlider.isHidden = false
        }else {
            radiusLabel.isHidden = true
            radiusSlider.isHidden = true
        }
        
        print("These are the input keys \(inputKeys)")
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey){
         currentFilter.setValue(radiusSlider.value * 300, forKey: kCIInputRadiusKey)
            print("This is radius Slider: \(radiusSlider.value)")
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
            self.imageView.image = processedImage
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


    @objc func image(_ image: UIImage, didFinishSavinWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error {
            let ac = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
        }else {
            let ac = UIAlertController(title: "Saved!", message: "You altered image has been saved to your photos", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
}


