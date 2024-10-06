//
//  SecretView.swift
//  Mini Calculator
//
//  Created by Akha on 06.10.2024.
//

import SwiftUI
import AVKit

struct SecretView: View {
    // Hardcoded list of video filenames
    let videos = ["video1.mp4", "video2.MP4"]
    
    var body: some View {
        List(videos, id: \.self) { video in
            Button(action: {
                playVideo(named: video)
            }) {
                Text(video)
                    .font(.headline)
            }
        }
        .navigationTitle("Video List")
    }
    
    // Function to play a video by name
    func playVideo(named videoName: String) {
        if let path = Bundle.main.path(forResource: videoName, ofType: nil) {
            let videoURL = URL(fileURLWithPath: path)
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            
            // Present the player view controller
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(playerViewController, animated: true) {
                    player.play()
                }
            }
        } else {
            print("Video not found: \(videoName)")
        }
    }
}

#Preview {
    SecretView()
}
