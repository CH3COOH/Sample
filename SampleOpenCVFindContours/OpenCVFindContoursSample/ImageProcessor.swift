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
    
    static func findContours2(image: UIImage?, withThreshold threshold: Double) -> UIImage? {
        guard let image = image else {
            return nil
        }

        let imgColor = Mat(uiImage: image)
        let imgGray = imgColor.clone()
        let imgBlur = imgColor.clone()
        let imgDist1 = imgColor.clone()
        let imgDist2 = imgColor.clone()

        // グレースケール変換
        Imgproc.cvtColor(src: imgColor, dst: imgGray, code: .COLOR_BGR2GRAY)

        saveImageToStorage(image: imgGray.toUIImage(), filename: "imgGray.jpg")
        
        // ぼかし処理
        Imgproc.blur(src: imgGray, dst: imgBlur, ksize: Size2i(width: 9, height: 9))

        saveImageToStorage(image: imgBlur.toUIImage(), filename: "imgBlur.jpg")

        // 二値化
        let imgBinary = Mat()
        Imgproc.threshold(
            src: imgBlur,
            dst: imgBinary,
            thresh: threshold,
            maxval: 255,
            type: .THRESH_BINARY
        )

        saveImageToStorage(image: imgBinary.toUIImage(), filename: "imgBinary.jpg")
        
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
            image: imgDist1,
            contours: contours,
            contourIdx: -1,
            color: Scalar(0, 255, 0, 255),
            thickness: 2
        )

        imgDist2.setTo(scalar: Scalar(0))
        Imgproc.drawContours(
            image: imgDist2,
            contours: contours,
            contourIdx: -1,
            color: Scalar(0, 255, 0, 255),
            thickness: 2
        )
        
        saveImageToStorage(image: imgDist1.toUIImage(), filename: "imgColor1.jpg")
        saveImageToStorage(image: imgDist2.toUIImage(), filename: "imgColor2.jpg")
        
        return imgDist1.toUIImage()
    }
    
    static func saveImageToStorage(image: UIImage, filename: String) {
        // JPEG形式に変換（ここでは品質を0.8に設定）
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            // ドキュメントディレクトリのパスを取得
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // 保存するファイルのフルパスを設定
                let fileURL = documentsDirectory.appendingPathComponent(filename)

                do {
                    // データをファイルに書き込む
                    try jpegData.write(to: fileURL, options: .atomic)
                    print("Image saved successfully to \(fileURL)")
                } catch {
                    print("Error saving image: \(error)")
                }
            }
        }
    }
}
