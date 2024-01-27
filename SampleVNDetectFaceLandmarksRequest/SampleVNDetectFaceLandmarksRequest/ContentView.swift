//
//  ContentView.swift
//  SampleVNDetectFaceLandmarksRequest
//
//  Created by KENJIWADA on 2024/01/27.
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
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
            }
            if let text = text {
                Text(text)
            }
            Button("face landmarks") {
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

        Task {
            do {
                // 画像を解析し、人物とパーツの位置情報を取得する
                let results = try await ImageProcessor.performFaceLandmarks(image: source)

                // 元画像にランドマークをマークする
                let image = ImageProcessor.drawFaceLandmarks(on: source, using: results ?? [])

                await MainActor.run {
                    self.image = image
                    self.text = nil
                }
            } catch {
                await MainActor.run {
                    image = UIImage(named: "sample")
                    text = "画像の変換に失敗"
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
