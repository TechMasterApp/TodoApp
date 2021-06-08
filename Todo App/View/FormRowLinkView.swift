//
//  FormRowLinkView.swift
//  Todo App
//
//  Created by Gaurav Bhasin on 3/19/21.
//

import SwiftUI

struct FormRowLinkView: View {
    // MARK: - PROPERTIES
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(.white)
                
            } //: ZSTACK
            .frame(width: 36, height: 36, alignment: .center)
            Text(text)
                .foregroundColor(.gray)
            
            Spacer()

            Link(destination: URL(string: link)!) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .accentColor(Color(.systemGray2))
            }
        } //: HSTACK
    }
}

// MARK: - PREVIEW
struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://swiftuimasterclass.com")
            .previewLayout(.fixed(width: 365, height: 60))
            .padding()
    }
}
