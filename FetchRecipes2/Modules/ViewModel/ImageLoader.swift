//
//  ImageLoader.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/7/24.
//

import SwiftUI

// Fetches images to be displayed asynchronously

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
        loadImage()
    }
    
    private func loadImage() {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
        .resume()
    }
}
