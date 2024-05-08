//
//  AsyncImageView.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/8/24.
//

import SwiftUI

// Displays image fetched from ImageLoader

struct AsyncImageView: View {
    @StateObject private var imageLoader: ImageLoader
    
    init(url: URL?) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        if let uiImage = imageLoader.image {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            ProgressView()
        }
    }
}
