//
//  ContentView.swift
//  CityTour
//
//

import SwiftUI

struct PlacesView: View {
    
    @StateObject private var viewModel = PlacesViewModel()
    
    private var HorizontalView : some View {
        ScrollView(.horizontal) {
            LazyHStack (spacing : 12){
                ForEach(Keyword.allCases) { keyword in
                    Button {
                        viewModel.selectedKeyword = keyword
                    } label: {
                        Text(keyword.title)
                            .foregroundStyle(viewModel.selectedKeyword == keyword ? Color.gray : Color.black)
                            .bold(true)
                            .padding(.horizontal, 10)
                    }

                }
            }
            .frame(height: 50)
        }
    }
    
    var body: some View {
        VStack {
            HorizontalView
            Spacer()
        }

    }
}

#Preview {
    PlacesView()
}
