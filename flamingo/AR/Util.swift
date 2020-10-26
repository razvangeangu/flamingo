//
//  Util.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 25/10/2020.
//

import Foundation
import ARKit

/// Save an image to the document directory
func saveImage(image: UIImage, name: String) {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileName = "\(name).jpg"
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
    if let data = image.jpegData(compressionQuality: 1.0) {
        // !FileManager.default.fileExists(atPath: fileURL.path)
        do {
            try data.write(to: fileURL)
            print("Card image saved")
        } catch {
            print("Error saving card image: ", error)
        }
    }
}

/// Create ARReference dynamically
func loadDynamicImageReferences() -> Set<ARReferenceImage> {
    var detectionImages: Set<ARReferenceImage> = Set()
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    do {
        let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
        fileURLs.forEach { (fileURL) in
            
            guard let imageFromBundle = UIImage(contentsOfFile: fileURL.path),
                  let imageToCIImage = CIImage(image: imageFromBundle),
                  let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage) else { return }
            
            let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.0856)
            arImage.name = fileURL.lastPathComponent
            detectionImages.insert(arImage)
        }
    } catch {
        print("Error while enumerating files \(documentsDirectory.path): \(error.localizedDescription)")
    }
    
    return detectionImages
}


/// Converts A CIImage To A CGImage
///
/// - Parameter inputImage: CIImage
/// - Returns: CGImage
private func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
    let context = CIContext(options: nil)
    if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
        return cgImage
    }
    return nil
}
