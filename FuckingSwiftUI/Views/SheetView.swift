//
//  SheetView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct SheetView: View {
    @State private var showSheet = false
    @State private var sheetMessage: MessageItem?
    
    @State private var fullScreenCover = false

    @State private var popover = false

    var body: some View {
        VStack(spacing: 20) {
            Button(".sheet") {
                showSheet.toggle()
            }
            
            Button(".sheet") {
                sheetMessage = MessageItem()
            }

            Button(".fullScreenCover") {
                fullScreenCover.toggle()
            }
            
            Button(".popover") {
                popover.toggle()
            }
        }
        .sheet(isPresented: $showSheet, content: {
            Text("111")
        })
        .sheet(item: $sheetMessage, content: { item in
            Text(item.message)
        })
        .fullScreenCover(isPresented: $fullScreenCover, onDismiss: {
            
        }, content: {
            FullScreen()
        })
        .popover(isPresented: $popover, content: {
            Text("Popover")
        })
        .navigationTitle("Sheet")
        .navigationBarTitleDisplayMode(.large)
    }
    
    struct MessageItem: Identifiable {
        let id = UUID()
        
        let message: String = "我是消息"
    }
    
    struct FullScreen: View {
        @Environment(\.dismiss) var dismiss
        var body: some View {
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SheetView()
        }
    }
}
