//
//  ContentView.swift
//  OpenCVSample
//
//  Created by KENJIWADA on 2024/01/03.
//

import SwiftUI
import opencv2

struct ContentView: View {
    @State private var image = UIImage(named: "sample")
    @State private var text: String?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
            }
            if let text = text {
                Text(text)
            }
            Button("to grayscale") {
                action()
            }
            Button("clear") {
                clear()
            }
        }
        .padding()
    }

    private func action() {
        guard let source = UIImage(named: "sample") else {
            text = "画像の取得に失敗"
            return
        }
        
        guard let image = convertToGrayScale(image: source) else {
            text = "画像の変換に失敗"
            return
        }

        self.image = image
        text = nil
    }

    private func clear() {
        image = UIImage(named: "sample")
        text = nil
    }
    
    private func convertToGrayScale(image: UIImage) -> UIImage? {
        guard let mat = Mat(uiImage: image) else { return nil }
        Imgproc.cvtColor(src: mat, dst: mat, code: Imgproc.COLOR_RGB2GRAY)
        return mat.toUIImage()
    }
}

#Preview {
    ContentView()
}
