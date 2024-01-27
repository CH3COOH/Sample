//
//  ImageProcessor.swift
//  SampleVNDetectFaceLandmarksRequest
//
//  Created by KENJIWADA on 2024/01/27.
//

import UIKit
import Vision

enum ImageProcessorError: Error {
    case faildLoadImage
}

enum ImageProcessor {
    static func performFaceLandmarks(
        image: UIImage
    ) async throws -> [VNFaceObservation]? {
        let faceLandmarksRequest: VNDetectFaceLandmarksRequest = .init()
        faceLandmarksRequest.preferBackgroundProcessing = true
        #if targetEnvironment(simulator)
            // シミュレータで実行する場合、`usesCPUOnly` を `true` にしないと例外を吐く
            faceLandmarksRequest.usesCPUOnly = true
        #endif

        let imageRequestHandler: VNImageRequestHandler
        if let ciImage = image.ciImage {
            imageRequestHandler = .init(
                ciImage: ciImage,
                orientation: .init(image.imageOrientation)
            )
        } else if let cgImage = image.cgImage {
            imageRequestHandler = .init(
                cgImage: cgImage
            )
        } else {
            // UIImageからの Vision で処理できるフォーマットへ変換できなかった
            throw ImageProcessorError.faildLoadImage
        }

        return try await withCheckedThrowingContinuation { continuation in
            do {
                try imageRequestHandler.perform([faceLandmarksRequest])
                continuation.resume(returning: faceLandmarksRequest.results)
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    static func drawFaceLandmarks(on image: UIImage, using observations: [VNFaceObservation]) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let renderedImage = renderer.image { context in
            image.draw(at: .zero)

            for observation in observations {
                let transform = CGAffineTransform(
                    translationX: observation.boundingBox.origin.x,
                    y: observation.boundingBox.origin.y
                )
                    .scaledBy(x: image.size.width, y: image.size.height)
                    .scaledBy(x: 1, y: -1)
                    .translatedBy(x: 0, y: -1)
                
                // 顔の領域に対して線を描画する
                let faceRect = observation.boundingBox.applying(transform)
                context.cgContext.setStrokeColor(UIColor.green.cgColor)
                context.cgContext.setLineWidth(2)
                context.stroke(faceRect)

                // ランドマークの描画
                if let landmarks = observation.landmarks {
                    drawLandmarks(landmarks, on: context.cgContext, within: faceRect)
                }
            }
        }
        return renderedImage
    }

    static func drawLandmarks(_ landmarks: VNFaceLandmarks2D, on context: CGContext, within rect: CGRect) {
        let transform = CGAffineTransform(translationX: rect.origin.x, y: rect.origin.y)
            .scaledBy(x: rect.size.width, y: rect.size.height)
            .scaledBy(x: 1, y: -1)
            .translatedBy(x: 0, y: -1)

        // 輪郭
        if let points = landmarks.faceContour {
            drawPoints(points, on: context, with: transform, color: .magenta)
        }

        // 目
        if let points = landmarks.rightEye {
            drawPoints(points, on: context, with: transform, color: .red)
        }
        if let points = landmarks.leftEye {
            drawPoints(points, on: context, with: transform, color: .red)
        }

        // 鼻
        if let points = landmarks.nose {
            drawPoints(points, on: context, with: transform, color: .red)
        }

        // 唇
        if let points = landmarks.outerLips {
            drawPoints(points, on: context, with: transform, color: .red)
        }
    }

    static func drawPoints(_ points: VNFaceLandmarkRegion2D, on context: CGContext, with transform: CGAffineTransform, color: UIColor) {
        guard let firstPoint = points.normalizedPoints.first else { return }

        context.beginPath()
        context.move(to: firstPoint.applying(transform))

        for point in points.normalizedPoints.dropFirst() {
            context.addLine(to: point.applying(transform))
        }

        context.closePath()
        context.setStrokeColor(color.cgColor)
        context.strokePath()
    }
}

extension CGImagePropertyOrientation {
    /// https://developer.apple.com/documentation/imageio/cgimagepropertyorientation
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        @unknown default:
            fatalError()
        }
    }
}
