//
//  ImageProcessor.swift
//  Filterer
//
//  Created by JSkophammer on 7/17/16.
//  Copyright © 2016 JScope. All rights reserved.
//

import Foundation
//: Playground - noun: a place where people can play

import UIKit

//let image = UIImage(named: "sample")!

//var myRGBA = RGBAImage(image: image)!
var lastAvgRed: Int!
var lastAvgGreen: Int!
var lastAvgBlue: Int!

public struct imageFilter{
    let image: RGBAImage
    // Computes average color of given image
    
    public func avgColor() -> (avgRed: Int, avgGreen: Int, avgBlue:Int) {
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        var countPixels = 0
        
        for y in 0..<self.image.height {
            for x in 0..<self.image.width {
                let index = y * self.image.width + x
                var pixel = self.image.pixels[index]
                countPixels += 1
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        return (totalRed/countPixels, totalGreen/countPixels, totalBlue/countPixels)
    }
    
    // Enhances color ("red", "green", or "blue") by a chosen factor
    // For example: enhanceColor("blue", factor: 5) enhances the blue pixels by 5x
    
    public func enhanceColor(color: String, factor: Int, apply: Bool) -> RGBAImage {
        var avgRed = 0
        var avgGreen = 0
        var avgBlue = 0
        if apply {
            let averageColor = avgColor()
            avgRed = averageColor.0
            avgGreen = averageColor.1
            avgBlue = averageColor.2
        }

        var imageNew: RGBAImage = self.image
        for y in 0..<self.image.height {
            for x in 0..<image.width {
                let index = y * self.image.width + x
                var pixel = self.image.pixels[index]
                switch color {
                case "red":
                    if apply {
                        lastAvgRed = avgRed
                        let redDiff = Int(pixel.red) - avgRed
                        if (redDiff>0) {
                            pixel.red = UInt8(max(0, min(255, avgRed + redDiff*factor)))
                            imageNew.pixels[index] = pixel
                        }
                    } else {
                        pixel.green = UInt8(lastAvgGreen)
                        imageNew.pixels[index] = pixel
                    }
                case "green":
                    if apply {
                        lastAvgGreen = avgGreen
                        let greenDiff = Int(pixel.green) - avgGreen
                        if (greenDiff>0) {
                            pixel.green = UInt8(max(0, min(255, avgGreen + greenDiff*factor)))
                            imageNew.pixels[index] = pixel
                        }
                    } else {
                        pixel.green = UInt8(lastAvgGreen)
                        imageNew.pixels[index] = pixel
                    }
                case "blue":
                    if apply {
                        lastAvgBlue = avgBlue
                        let blueDiff = Int(pixel.blue) - avgBlue
                        if (blueDiff>0) {
                            pixel.blue = UInt8(max(0, min(255, avgBlue + blueDiff*factor)))
                            imageNew.pixels[index] = pixel
                        }
                    } else {
                        pixel.blue = UInt8(lastAvgBlue)
                        imageNew.pixels[index] = pixel
                    }
                default:
                    imageNew.pixels[index] = pixel
                }
            }
        }
        return imageNew
    }
    
    // Adjusts the brightness of given image
    // Takes + and - values in brightness parameter to make lighter or darker
    
    public func adjustBright(brightness: Int) -> RGBAImage {
        var imageNew: RGBAImage = self.image
        let addBright = (256/100) * brightness
        for y in 0..<self.image.height {
            for x in 0..<self.image.width {
                let index = y * self.image.width + x
                var pixel = self.image.pixels[index]
                pixel.red = UInt8(max(0, min(255, Int(pixel.red) + addBright)))
                pixel.green = UInt8(max(0, min(255, Int(pixel.green) + addBright)))
                pixel.blue = UInt8(max(0, min(255, Int(pixel.blue) + addBright)))
                imageNew.pixels[index] = pixel
            }
        }
        return imageNew
    }
}
/*
 Predefined Filters:
 1. "25% Brightness"
 2. "50% Brightness"
 3. "Enhance Red 5x"
 4. "Enhance Green 5x"
 5. "Enhance Blue 5x"
 
 Set above string values to definedFilter parameter to select given filter
 */

public struct imageProcessor {
    public let image: RGBAImage
    public var definedFilter: String?
    
    public func processImage() -> RGBAImage {
        var imageNew: RGBAImage
        if (self.definedFilter != nil){
            switch self.definedFilter! {
            case "25% Brightness":
                let newFilter = imageFilter(image: image)
                imageNew = newFilter.adjustBright(25)
            case "50% Brightness":
                let newFilter = imageFilter(image: image)
                imageNew = newFilter.adjustBright(50)
            case "Enhance Red 5x":
                let newFilter = imageFilter(image: image)
                imageNew = newFilter.enhanceColor("red", factor: 5, apply: true)
            case "Enhance Green 5x":
                let newFilter = imageFilter(image: image)
                imageNew = newFilter.enhanceColor("green", factor: 5, apply: true)
            case "Enhance Blue 5x":
                let newFilter = imageFilter(image: image)
                imageNew = newFilter.enhanceColor("blue", factor: 5, apply: true)
            default:
                let newFilter = imageFilter(image: image)
                imageNew = newFilter.adjustBright(0)
            }
        } else {
            let newFilter = imageFilter(image: image)
            imageNew = newFilter.adjustBright(0)
        }
        return imageNew
    }
}

// Example of image processor in action with "50% Brightness" predefined filter

//let newImage = imageProcessor(image: myRGBA, definedFilter: "Enhance Red 5x")
//newImage.processImage().toUIImage()







