//
//  ContentView.swift
//  OpenCVFindContoursSample
//
//  Created by KENJIWADA on 2024/01/04.
//

import SwiftUI

struct ContentView: View {
    @State private var image = UIImage(named: "sample")
    @State private var text: String?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
            }
            if let text = text {
                Text(text)
            }
            Button("findContours") {
                action()
            }
            Button("clear") {
                // 初期状態に戻す
                image = UIImage(named: "sample")
                text = nil
            }
        }
        .padding()
    }

    private func action() {
        guard let source = UIImage(named: "sample") else {
            text = "画像の取得に失敗"
            return
        }
        
        guard let image = ImageProcessor.findContours2(image: source, withThreshold: 140) else {
            text = "画像の変換に失敗"
            return
        }

        self.image = image
        text = nil
    }
}

#Preview {
    ContentView()
}
