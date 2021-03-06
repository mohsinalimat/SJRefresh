//
//  UIImage+Gif.swift
//  Pods
//
//  Created by Subins Jose on 16/11/16.
//  Copyright © 2016 Subins Jose. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//    and associated documentation files (the "Software"), to deal in the Software without
//	  restriction, including without limitation the rights to use, copy, modify, merge, publish,
//    distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
//	  the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//    substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
//  AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


import UIKit
import ImageIO

extension UIImage {

	class func imagesFromGif(_ name: String) -> [UIImage]? {

		// Check for existance of gif
		guard let bundleURL = Bundle.main
			.url(forResource: name, withExtension: "gif") else {
				print("This image named \"\(name)\" does not exist")
				return nil
		}

		return UIImage.imagesFromGifURL(bundleURL)
	}

	class func imagesFromGifURL(_ url: URL) -> [UIImage]? {

		// Validate data
		guard let imageData = try? Data(contentsOf: url) else {
			print("Cannot turn image named \"\(url)\" into NSData")
			return nil
		}

		return UIImage.imagesFromGifData(imageData)
	}

	class func imagesFromGifData(_ data: Data) -> [UIImage]? {

		// Create source from data
		guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
			print("Source for the image does not exist")
			return nil
		}

		let count = CGImageSourceGetCount(source)
		var images = [UIImage]()

		// Fill arrays
		for index in 0..<count {
			// Add image
			if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
				images.append(UIImage(cgImage: image))
			}
		}

		return images
	}
}
