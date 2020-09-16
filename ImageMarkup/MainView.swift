//
//  MainView.swift
//  ImageMarkup
//
//  Created by Matt Dias on 9/15/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.
//

import SwiftUI
import Combine

struct MainView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("Viewing r/aww")
                .font(.title)
            List(viewModel.images, id: \.index) { indexImage in
                Image(uiImage: indexImage.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Button(action: viewModel.getData) {
                Text("Fetch")
                    .bold()
            }
            Spacer(minLength: 16)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
