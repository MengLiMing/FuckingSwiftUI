//
//  ImageView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

struct ImageView: View {
    @State private var blendMode: BlendMode = .hue
    private let blendModes: [BlendMode] = [
        .normal,
        .multiply,
        .screen,
        .overlay,
        .darken,
        .lighten,
        .colorDodge,
        .colorBurn,
        .softLight,
        .hardLight,
        .difference,
        .exclusion,
        .hue,
        .saturation,
        .color,
        .luminosity,
        .sourceAtop,
        .destinationOver,
        .destinationOut,
        .plusDarker,
        .plusLighter
    ]
    
    var body: some View {
        VStack {
            icon
                .frame(width: 100, height: 80)
                .clipped()
                .border(.red, width: 1)
            
            icon
                .resizable()
                .frame(width: 100, height: 80)
                .border(.red, width: 1)
            
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 80)
                .border(.red, width: 1)
            
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 80, alignment: .leading)
                .border(.red, width: 1)
            
            icon
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 80)
                .clipped()
                .border(.red, width: 1)
            
            AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/19296728?s=400&u=7a099a186684090f50459c87176cf4d291a27ac7&v=4"), transaction: .init(animation: .spring())) { phase in
                if phase.image == nil {
                    ProgressView()
                } else {
                    phase.image!
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            }
            
            AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/19296728?s=400&u=7a099a186684090f50459c87176cf4d291a27ac7&v=4")) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }

            
            VStack {
                ZStack {
                    icon
                        .resizable()
                    
                    Color.yellow
                        .blendMode(blendMode)
                }
                .frame(width: 100, height: 100)
                
                Picker(selection: $blendMode) {
                    ForEach(blendModes, id: \.self) {
                        Text($0.desc)
                            .tag($0)
                    }
                } label: {
                    Text("Picker ")
                }

            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Image + AsyncImage")
    }
    
    var icon: Image {
        Image("icon")
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}

extension BlendMode {
    var desc: String {
        "\(self)"
    }
}
