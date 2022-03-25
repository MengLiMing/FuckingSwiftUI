//
//  ContentView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                viewAndControls
                
                viewLayoutAndPresentation
                
                uiKit
            }
            .navigationTitle("Fucking SwiftUI")
        }
    }
    
    var uiKit: some View {
        Group {
            Section("UIViewRepresentable") {
                ContentRow(title: "UIActivityIndicatorView").navigationLink {
                    ActivityIndicatorView(isAnimating: .constant(true))
                        .navigationTitle("UIActivityIndicatorView")
                }
                
                ContentRow(title: "UIVisualEffectView").navigationLink {
                    BlurDemo()
                }
            }
            
            Section("UIViewControllerRepresentable") {
                ContentRow(title: "PHPickerViewController").navigationLink {
                    ImagePickerDemo()
                }
            }
        }
    }
    
    var viewLayoutAndPresentation: some View {
        Section("View Layout and Presentation") {
            Group {
                ContentRow(title: "HStack + LazyHStack").navigationLink {
                    HStackView()
                }
                
                ContentRow(title: "VStack + LazyVStack").navigationLink {
                    VStackView()
                }
                
                ContentRow(title: "List").navigationLink {
                    ListView()
                }
                
                ContentRow(title: "LazyVGridView + LazyHGridView").navigationLink {
                    LazyH_VGridView()
                }
                
                ContentRow(title: "Form").navigationLink {
                    FormView()
                }
                
                ContentRow(title: "NavigationView").navigationLink {
                    NavigationViewPage()
                }
                
                ContentRow(title: "TabView").navigationLink {
                    TabViewPage()
                }
            }
            
            Group {
                ContentRow(title: ".alert").navigationLink {
                    AlertView()
                }
                
                ContentRow(title: ".sheet").navigationLink {
                    SheetView()
                }
                
                ContentRow(title: ".confirmationDialog").navigationLink {
                    ConfirmationDialogView()
                }
            }
        }
    }

    
    var viewAndControls: some View {
        Section("Views and Controls") {
            Group {
                ContentRow(title: "Text").navigationLink {
                    TextView()
                }
                
                ContentRow(title: "Label").navigationLink {
                    LabelView()
                }
                
                ContentRow(title: "TextField").navigationLink {
                    TextFieldView()
                }
                
                ContentRow(title: "TextEditor").navigationLink {
                    TextEditorView()
                }
             
                ContentRow(title: "Image").navigationLink {
                    ImageView()
                }
            }
            
            Group {
                ContentRow(title: "Button").navigationLink {
                    ButtonView()
                }
                
                ContentRow(title: "NavigationLink").navigationLink {
                    NavigationLinkView()
                }
                
                ContentRow(title: "Toggle").navigationLink {
                    ToggleView()
                }
                
                ContentRow(title: "Map").navigationLink {
                    MapView()
                }
                
                ContentRow(title: "Picker").navigationLink {
                    PickerView()
                }
                
                ContentRow(title: "DatePicker").navigationLink {
                    DatePickerView()
                }
                
                ContentRow(title: "ProgressView").navigationLink {
                    ProgressViewPage()
                }
                
                ContentRow(title: "Slider").navigationLink {
                    SliderView()
                }
                
                ContentRow(title: "Stepper").navigationLink {
                    StepperView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

