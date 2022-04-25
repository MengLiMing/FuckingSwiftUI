//
//  OperatorView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/22.
//

import SwiftUI

struct OperatorView: View {
    var body: some View {
        List {            
            Cell(title: "collect") {
                CollectView()
            }
            
            Cell(title: "allSatisfy") {
                AllSatisfyView()
            }
            
            Group {
                Cell(title: "dropWhile") {
                    DropView()
                }
                
                Cell(title: "prepend") {
                    PrependView()
                }
                
                Cell(title: "prefix") {
                    PrefixView()
                }
            }
            
            NavigationLink {
                CombineView()
            } label: {
                VStack(alignment: .leading) {
                    ForEach(["combineLatest", "merge", "zip"], id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Group {
                Cell(title: "debounce") {
                    DebounceView()
                }
                
                Cell(title: "throttle") {
                    ThrottleView()
                }
            }
            
            Cell(title: "breakpint") {
                BreakPointView()
            }
        }
        .navigationTitle("操作符")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OperatorView_Previews: PreviewProvider {
    static var previews: some View {
        OperatorView()
    }
}
