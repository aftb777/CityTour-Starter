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
            LazyHStack (spacing : 12) {
                ForEach(Keyword.allCases) { keyword in
                    Button(action: {
                        viewModel.selectedKeyword = keyword
                    }, label: {
                        Text(keyword.title)
                            .foregroundStyle(
                                viewModel.selectedKeyword == keyword ? Color.gray : Color.black
                            )
                            .bold(true)
                            .padding(.horizontal, 10)
                    }) .scaleEffect(viewModel.selectedKeyword == keyword ? 0.8 : 1.0)
                }
            }
            .frame(height: 50)
        }
    }

    
    var body: some View {
        VStack {
            HorizontalView
            
            List {
                ForEach(viewModel.places) { place in
                    HStack{
                        VStack{
                            Text(place.name)
                            Text(place.vicinity)
                            
                        }
                    }
                    .overlay(alignment: .trailing) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.yellow)
                    }

                }
            }
            Spacer()
        }

    }
}

#Preview {
    PlacesView()
}
