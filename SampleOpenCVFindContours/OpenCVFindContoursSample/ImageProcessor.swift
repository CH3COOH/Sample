//
//  ImageProcessor.swift
//  OpenCVFindContoursSample
//
//  Created by KENJIWADA on 2024/01/05.
//

import opencv2
import UIKit

enum ImageProcessor {
    static func findContours(image: UIImage?, withThreshold threshold: Double) -> UIImage? {
        guard let image = image else {
            return nil
        }

        let imgColor = Mat(uiImage: image)
        let imgGray = imgColor.clone()
        let imgBlur = imgGray.clone()

        // グレースケール変換
        Imgproc.cvtColor(src: imgColor, dst: imgGray, code: .COLOR_BGR2GRAY)

        // ぼかし処理
        Imgproc.blur(src: imgGray, dst: imgBlur, ksize: Size2i(width: 9, height: 9))

        // 二値化
        let imgBinary = Mat()
        Imgproc.threshold(
            src: imgBlur,
            dst: imgBinary,
            thresh: threshold,
            maxval: 255,
            type: .THRESH_BINARY
        )

        // 輪郭検出
        let contoursNSMutableArray: NSMutableArray = []
        let hierarchy = Mat()
        Imgproc.findContours(
            image: imgBinary,
            contours: contoursNSMutableArray,
            hierarchy: hierarchy,
            mode: RetrievalModes.RETR_TREE,
            method: ContourApproximationModes.CHAIN_APPROX_SIMPLE
        )

        // 輪郭描画
        var contours: [[Point2i]] = []
        for contourObj in contoursNSMutableArray {
            if let contour = contourObj as? [Point2i] {
                contours.append(contour)
            }
        }
        Imgproc.drawContours(
            image: imgColor,
            contours: contours,
            contourIdx: -1,
            color: Scalar(0, 255, 0, 255),
            thickness: 2
        )

        return imgColor.toUIImage()
    }
}
