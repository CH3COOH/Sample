//
//  ImageProcessor.swift
//  OpenCVSample
//
//  Created by KENJIWADA on 2024/01/05.
//

import opencv2
import UIKit

enum ImageProcessor {
    static func grayscale(image: UIImage?) -> UIImage? {
        guard let image = image else {
            return nil
        }

        let mat = Mat(uiImage: image)
        Imgproc.cvtColor(
            src: mat,
            dst: mat,
            code: ColorConversionCodes.COLOR_RGB2GRAY
        )
        return mat.toUIImage()
    }
}
