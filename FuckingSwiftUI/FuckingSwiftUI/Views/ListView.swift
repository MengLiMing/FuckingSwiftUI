//
//  ListView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct ListView: View {
    @State private var items = [
        Item(name: "AAA"),
        Item(name: "BBB"),
        Item(name: "CCC"),
        Item(name: "DDD"),
        Item(name: "EEE"),
    ]
    
    @State private var selection: Set<Item> = []
    
    var body: some View {
        List(selection: $selection) {
            ForEach(items, id: \.self) {
                Text($0.name)
            }
            .onDelete { index in
                items.remove(atOffsets: index)
            }
            .onMove { from, to in
                items.move(fromOffsets: from, toOffset: to)
            }
        }
        .listStyle(.grouped)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("List")
        .toolbar {
            EditButton()
        }
    }
}

extension ListView {
    struct Item: Identifiable, Hashable {
        let name: String
        let id = UUID()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
    }
}
