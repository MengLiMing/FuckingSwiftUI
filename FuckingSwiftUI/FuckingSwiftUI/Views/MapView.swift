//
//  MapView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.280548, longitude: 120.001278), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    @State private var items: [Location] = [
        Location(name: "欧美金融中心", coordinate: .init(latitude: 30.280548, longitude: 120.001278)),
        Location(name: "创景路地铁口", coordinate: .init(latitude: 30.279497, longitude: 119.998587))
    ]
    
    @State private var selectedItem: Location?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: items) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Text(location.name)
                            .padding()
                            .onTapGesture {
                                selectedItem = location
                            }
                    }
                }
                
                Image(systemName: "circle.circle.fill")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.red)
            }
            
            Text("中心坐标：\(mapRegion.center.latitude) - \(mapRegion.center.longitude)")
                .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Map")
        .popover(item: $selectedItem, content: { item in
            Text(item.name)
        })
        .ignoresSafeArea()
    }
}

extension MapView {
    struct Location: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
