//
//  ImagePicker.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct ImagePickerDemo: View {
    @State private var images: [UIImage] = []
    @State private var size: CGSize?
    
    @State private var showChooseImage = false
    
    let vSpace: CGFloat = 10
    let hSpace: CGFloat = 10
    let col: Int = 3
    
    var itemWidth: CGFloat {
        guard let size = size else {
            return 0
        }
        return (size.width - CGFloat(col + 1) * hSpace) / CGFloat(col)
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: itemWidth, maximum: itemWidth), spacing: hSpace)
            ], spacing: 10) {
                ForEach(Array(images.indices), id: \.self) { index in
                    let image = images[index]
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: itemWidth, height: itemWidth)
                            .clipped()
                            .cornerRadius(10)
                            .transition(.identity)
                            .id(UUID())
                        
                        Image(systemName: "minus.circle.fill")
                            .frame(width: 10, height: 10)
                            .padding(10)
                            .offset(x: 15, y: -15)
                            .onTapGesture {
                                withAnimation {
                                   _ = self.images.remove(at: index)
                                }
                            }
                    }
                    .frame(width: itemWidth, height: itemWidth)
                }
                
                if images.count < 3 {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.2))
                        .frame(height: itemWidth)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.largeTitle)
                        )
                        .onTapGesture {
                            showChooseImage.toggle()
                        }
                }
            }
            .popover(isPresented: $showChooseImage, content: {
                ImagePicker(image: Binding<UIImage?>(get: {
                    nil
                }, set: { image in
                    guard let image = image else {
                        return
                    }
                    withAnimation {
                        images.append(image)
                    }
                }))
            })
            .currentSize($size)
            
            Spacer()
        }
    }
}

struct ImagePickerDemo_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerDemo()
    }
}


import PhotosUI
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = context.coordinator
        return pickerVC
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
            super.init()
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            
            guard let provider = results.first?.itemProvider else {
                return
            }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}
