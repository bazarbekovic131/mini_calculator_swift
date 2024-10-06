//
//  VideoViewerView.swift
//  Mini Calculator
//
//  Created by Akha on 06.10.2024.
//

import SwiftUI

struct VideoViewerView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoName: String

    var body: some View {
        VStack {
            if let url = Bundle.main.path(forResource: videoName, ofType: nil) {
                let videoURL = URL(fileURLWithPath: url)
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
            } else {
                Text("Video not found")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            dismiss()
        }
    }

    private func dismiss() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
}

struct ImageViewer: View {
    let imageName: String

    var body: some View {
        VStack {
            if let image = UIImage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .background(Color.black)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Image not found")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            // Dismiss the full-screen viewer
            dismiss()
        }
    }

    private func dismiss() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
}
