//
//  ViewController.swift
//  Filterer
//
//  Created by JSkophammer on 7/10/16.
//  Copyright © 2016 JScope. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var redFilter: UIButton!
    @IBOutlet var greenFilter: UIButton!
    @IBOutlet var blueFilter: UIButton!
    @IBOutlet var brighterByQuarter: UIButton!
    @IBOutlet var brighterByHalf: UIButton!
    
    var filteredImage: UIImage?
    var currentImage: UIImage?
    var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalImage = imageView.image
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func onCompare(sender: UIButton) {
        if (sender).selected {
            imageView.image = filteredImage
            (sender).selected = false
        } else {
            imageView.image = originalImage
            (sender).selected = true
        }
    }
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: {
            action in
            self.showCamera()
            }))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: {
            action in
            self.showAlbum()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.sourceType = .PhotoLibrary
        presentViewController(albumPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            originalImage = imageView.image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }
    
    @IBAction func onRedFilter(sender: UIButton) {
        if redFilter.selected {
            imageView.image = currentImage
            redFilter.selected = false
        } else {
            currentImage = imageView.image
            let rgbaImage = RGBAImage(image: currentImage!)!
            let imageFilter = imageProcessor(image: rgbaImage, definedFilter: "Enhance Red 5x")
            filteredImage = imageFilter.processImage().toUIImage()
            imageView.image = filteredImage
            //currentImage = filteredImage
            redFilter.selected = true
            print("red filter selected")
        }
    }
    
    @IBAction func onGreenFilter(sender: UIButton) {
        if greenFilter.selected {
            imageView.image = currentImage
            greenFilter.selected = false
        } else {
            currentImage = imageView.image
            let rgbaImage = RGBAImage(image: currentImage!)!
            let imageFilter = imageProcessor(image: rgbaImage, definedFilter: "Enhance Green 5x")
            filteredImage = imageFilter.processImage().toUIImage()
            imageView.image = filteredImage
            //currentImage = filteredImage
            greenFilter.selected = true
            print("green filter selected")
        }
    }
    
    @IBAction func onBlueFilter(sender: UIButton) {
        if blueFilter.selected {
            imageView.image = currentImage
            blueFilter.selected = false
        } else {
            currentImage = imageView.image
            let rgbaImage = RGBAImage(image: currentImage!)!
            let imageFilter = imageProcessor(image: rgbaImage, definedFilter: "Enhance Blue 5x")
            filteredImage = imageFilter.processImage().toUIImage()
            imageView.image = filteredImage
            //currentImage = filteredImage
            blueFilter.selected = true
            print("blue filter selected")
        }
    }
    
    @IBAction func onQuarterBrighter(sender: UIButton) {
        if brighterByQuarter.selected {
            imageView.image = currentImage
            brighterByQuarter.selected = false
        } else {
            currentImage = imageView.image
            let rgbaImage = RGBAImage(image: currentImage!)!
            let imageFilter = imageProcessor(image: rgbaImage, definedFilter: "25% Brightness")
            filteredImage = imageFilter.processImage().toUIImage()
            imageView.image = filteredImage
            //currentImage = filteredImage
            brighterByQuarter.selected = true
            print("25% Brighter filter selected")
        }
    }
    
    @IBAction func onHalfBrighter(sender: UIButton) {
        if brighterByHalf.selected {
            imageView.image = currentImage
            brighterByHalf.selected = false
        } else {
            currentImage = imageView.image
            let rgbaImage = RGBAImage(image: currentImage!)!
            let imageFilter = imageProcessor(image: rgbaImage, definedFilter: "50% Brightness")
            filteredImage = imageFilter.processImage().toUIImage()
            imageView.image = filteredImage
            //currentImage = filteredImage
            brighterByHalf.selected = true
            print("50% brighter filter selected")
        }
    }
    
    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
        }) { completed in
            if completed == true {
                self.secondaryMenu.removeFromSuperview()
            }
            
        }
    }
}




/*
    
    @IBAction func onImageToggle(sender: UIButton) {
        if imageToggle.selected {
            let image = UIImage(named: "purple_sky")!
            imageView.image = image
            imageToggle.selected = false
        } else {
            imageView.image = filteredImage
            imageToggle.selected = true
        }

    }
 */

/*
        //imageToggle.setTitle("Show Before Image", forState: .Selected)
        
        let image = UIImage(named: "purple_sky")!
        var rgbaImage = RGBAImage(image: image)!
        
        let avgRed = 10 // avgGreen = 100, avgBlue = 188
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                let redDelta   = Int(pixel.red)   - avgRed
                var modifier = 1 + 4*(Double(y)/Double(rgbaImage.height))
                if (Int(pixel.red) < avgRed) {
                    modifier = 1
                }
                pixel.red = UInt8(max(min(255, Int(round(Double(avgRed) + modifier * Double(redDelta)))),0))
                rgbaImage.pixels[index] = pixel
            }
        }
        filteredImage = rgbaImage.toUIImage()
    }
*/



