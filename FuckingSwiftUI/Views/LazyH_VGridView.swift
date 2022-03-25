//
//  LazyH_VGridView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct LazyH_VGridView: View {
    @State private var vgridWidth: CGFloat = UIScreen.main.bounds.width
    @State private var hgridHeight: CGFloat = UIScreen.main.bounds.height

    @State private var columns: [GridItem] = []
    
    private let fix: [GridItem] = [
        GridItem(.fixed(100), spacing: 10, alignment: .top),
        GridItem(.fixed(150), spacing: 10, alignment: .top),
        GridItem(.fixed(100), spacing: 10, alignment: .top),
    ]
    
    private let flexible: [GridItem] = [
        GridItem(.flexible(minimum: 60, maximum: 100), spacing: 10, alignment: .top),
        GridItem(.flexible(minimum: 70, maximum: 100), spacing: 10, alignment: .top),
        GridItem(.flexible(minimum: 80, maximum: 100), spacing: 10, alignment: .top)
    ]
    
    private let adaptive: [GridItem] = [
        GridItem(.adaptive(minimum: 60, maximum: 100), spacing: 10, alignment: .top)
    ]
    
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            vgrid
                .tabItem {
                    Label("LazyVGrid", systemImage: "v.circle.fill")
                }
                .tag(0)
            
            hgrid
                .tabItem {
                    Label("LazyHGrid", systemImage: "h.circle.fill")
                }
                .tag(1)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("LazyGridView")
    }
    
    var hgrid: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: adaptive, alignment: .top) {
                    ForEach(0..<1000) { index in
                        Rectangle()
                            .fill(Color.random)
                            .frame(width: 100)
                            .overlay(Text("\(index)"))
                            .id(index)
                    }
                }
            }
            .frame(maxHeight: hgridHeight)
            .border(.red, width: 1)
            
            
            Slider(value: $hgridHeight, in: 0...UIScreen.main.bounds.height)
                .padding()
        }
    }
    
    var vgrid: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                    ForEach(0..<100) { index in
                        Rectangle()
                            .fill(Color.random)
                            .frame(height: 100)
                            .overlay(Text("\(index)"))
                            .id(index)
                    }
                }
            }
            .frame(width: vgridWidth)
            .border(.red, width: 1)
            
            Slider(value: $vgridWidth, in: 0...UIScreen.main.bounds.width)
                .padding()
            
            HStack {
                Button("fix") {
                    columns = fix
                }
                Button("flexible") {
                    columns = flexible
                }
                Button("adaptive") {
                    columns = adaptive
                }
            }
            .buttonStyle(.bordered)
        }
        .onAppear {
            columns = fix
        }
    }
}

struct LazyH_VGridView_Previews: PreviewProvider {
    static var previews: some View {
        LazyH_VGridView()
    }
}
