//
//  SettingsView.swift
//  Todo App
//
//  Created by Gaurav Bhasin on 3/19/21.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    // MARK: - THEME
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    @State private var isThemeChanged = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION 1
                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $iconSettings.currentIndex, label:
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .strokeBorder(Color.primary, lineWidth: 2)
                                        Image(systemName: "paintbrush")
                                            .font(.system(size: 28, weight: .regular, design: .default))
                                            .foregroundColor(.primary)
                                    }
                                    .frame(width: 44, height: 44)
                            
                                    Text("App Icons".uppercased())
                                        .bold()
                                        .foregroundColor(.primary)
                                } //: LABEL
                            ) {
                                ForEach(0..<iconSettings.iconNames.count) { index in
                                    HStack {
                                        Image(uiImage: UIImage(named: iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 44, height: 44)
                                            .cornerRadius(9)
                                        
                                        Spacer().frame(width: 8)
                                        
                                        Text(iconSettings.iconNames[index] ?? "Blue")
                                            .frame(alignment: .leading)
                                    } //: HSTACK
                                    .padding(3)
                                }
                            } //: PICKER
                            .onReceive([iconSettings.currentIndex].publisher.first()) { value in
                                let index = iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                                if index != value {
                                    UIApplication.shared.setAlternateIconName(iconSettings.iconNames[value]) { error in
                                        if let error = error {
                                            print(error.localizedDescription)
                                        } else {
                                            print("Success! You have changed the app icon.")
                                        }
                                    }
                                }
                            }
                        } //: SECTION 1
                        .padding(.vertical, 3)
                    
                        // MARK: - SECTION 2
                        Section(header:
                            HStack {
                                Text("Choose the app theme")
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(themes[theme.themeSettings].themeColor)
                            }
                        ) {
                            List {
                                ForEach(themes, id: \.id) { item in
                                    Button(action: {
                                        theme.themeSettings = item.id
                                        UserDefaults.standard.set(theme.themeSettings, forKey: "Theme")
                                        isThemeChanged.toggle()
                                    }) {
                                        HStack {
                                            Image(systemName: "circle.fill")
                                                .foregroundColor(item.themeColor)
                                            
                                            Text(item.themeName)
                                        }
                                    } //: BUTTON
                                    .accentColor(Color.primary)
                                }
                            }
                        } //: SECTION 2
                        .padding(.vertical, 3)
                        .alert(isPresented: $isThemeChanged) {
                            Alert(
                                title: Text("SUCCESS!"),
                                message: Text("App has been changed to the \(themes[theme.themeSettings].themeName). Now close and restart it!"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        
                        // MARK: - SECTION 3
                        Section(header: Text("Follow us in social media")) {
                            FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://techmasterapp.wixsite.com/techmaster")
                            
                            FormRowLinkView(icon: "link", color: .blue, text: "Youtube", link: "https://www.youtube.com/channel/UCvitmg9FPVKXPpKVe15vrIA")
                            
                            FormRowLinkView(icon: "play.rectangle", color: .green, text: "Courses", link: "https://techmasterapp.wixsite.com/techmaster/xcode-tutorials")
                        } //: SECTION 3
                        .padding(.vertical, 3)
                        
                        // MARK: - SECTION 4
                        Section(header: Text("About the application")) {
                            FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                            
                            FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                            
                            FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Aarav Bhasin")
                            
                            FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Aarav Bhasin")
                            
                            FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                        } //: SECTION 4
                        .padding(.vertical, 3)
                    } //: FORM
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                    
                    // MARK: - FOOTER
                    Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .padding(.top, 6)
                        .padding(.bottom, 8)
                        .foregroundColor(Color.secondary)
                } //: VSTACK
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                        }
                    }
                }
                .navigationBarTitle("Settings", displayMode: .inline)
                .background(
                    Color("ColorBackground")
                        .edgesIgnoringSafeArea(.all)
            )
        } //: NAVIGATION
        .accentColor(themes[theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(IconNames())
    }
}
