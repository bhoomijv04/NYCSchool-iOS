//
//  NYCErrorView.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 26/11/23.
//

import SwiftUI

struct NYCErrorView: View {
    private var title: String
    private var subTitle: String
    private var retryBtnText: String
    private var imageName: String
    private let action: () -> Void
    
    init(title: String, subTitle: String, retryBtnText: String, imageName: String, action: @escaping () -> Void ) {
        self.title = title
        self.subTitle = subTitle
        self.action = action
        self.retryBtnText = retryBtnText
        self.imageName = imageName
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: imageName).renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundColor(.blue)
            Text(title)
                .foregroundColor(.primary)
                .font(.title)
                .fontWeight(.semibold)
                .accessibilityAddTraits(.isHeader)
                .padding([.top, .bottom], 10)
            Text(subTitle)
                .foregroundColor(.secondary)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Button {
                action()
            } label: {
                Label(retryBtnText, systemImage: "arrow.uturn.backward")
            }
            .frame(width: 300, height: 50)
            .buttonStyle(.bordered)
            .tint(.blue)
            .padding([.top], 10)
        }
    }
}
