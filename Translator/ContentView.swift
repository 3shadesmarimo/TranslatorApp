//
//  ContentView.swift
//  Translator
//
//  Created by Bilegt Davaa on 2023-03-15.
//  Aight

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
        
    
    @State var textfieldText: String = ""
    @State var textfieldText2 : String = ""
    @State var selectedOption = Language.english
    @State var selectedOption2 = Language.english

    @State private var translations: [(fromText: String, toText: String)] = []
    
    @State private var translator: Translator?
    
    let options = Language.allCases.map { $0.name }
    let options2 = Language.allCases.map { $0.name }
    
    
    
    var body: some View {
        
        
        NavigationView{
            VStack {
                
                
                HStack{
                    Text("From:")
                        .font(.title3)
                    Spacer().frame(width: 200)
                    Text("To:")
                        .font(.title3)
                }
                
                HStack {
                    
                    
                    Picker(selection: $selectedOption, label: Text("Select language")){
                        ForEach(Language.allCases, id: \.self){ option in
                            Text(option.name).tag(option.rawValue)
                        }
                        .frame(height: 50)
                    }

                    
                    
                    Spacer().frame(width: 150)
                    
                    
                    Picker(selection: $selectedOption2, label: Text("Select language")){
                        ForEach(Language.allCases, id: \.self){ option in
                            Text(option.name).tag(option.rawValue)
                        }
                        .frame(height: 50)
                    }

                    
                }
                
                TextField("Type something to translate...", text: $textfieldText)
                //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 120)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                
                Spacer().frame(height: 40)
                
                TextField("Translated text...", text: $textfieldText2)
                //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 120)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                //.disabled(true)
                
                Spacer().frame(height: 40)
                
                
                Button(action: {
                    
                    if let apiKey = ProcessInfo.processInfo.environment["TRANSLATOR_API_KEY"] {
                        let translator = Translator(key: apiKey, endpoint: "https://api.cognitive.microsofttranslator.com", location: "eastus")
                        self.translator = translator // assign the new instance of Translator to the @State property
                    } else {
                        print("TRANSLATOR_API_KEY environment variable not set")
                        return // return early if the API key is not set
                    }
                    
                    guard let translator = self.translator else {
                        print("Translator is nil")
                        return // return early if translator is nil
                    }
                    
                    //this is using the translate1 method
                    translator.translate1(text: textfieldText, to: [selectedOption2.rawValue]) { result, error in
                        DispatchQueue.main.async {
                            if let result = result {
                                textfieldText2 = result
                                translations.append((fromText: textfieldText, toText: result))
                            } else {
                                textfieldText2 = "Translation failed. Please try again"
                            }
                        }
                    }

                    
                    
                    //the code below is an implentation where it doesn't recognize the source language
                    /*
                    translator.translate(text: textfieldText, from: selectedOption, to: [selectedOption2]) { result, error in
                        DispatchQueue.main.async {
                            if let result = result {
                                textfieldText2 = result
                                translations.append((fromText: textfieldText, toText: result))
                            } else{
                                textfieldText2 = "Translation failed. Please try again."
                            }
                        }
                        
                    }
                    */
                    
                }, label: {
                    Text("Translate")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.cornerRadius(10))
                        .foregroundColor(.white)
                })
            }
            .navigationTitle("Translator App")
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink(destination: HistoryView(translations: translations, textfieldText: $textfieldText, textfieldText2: $textfieldText2)) {
                        Label("History", systemImage: "list.bullet.circle")
                    }
                    
                }
                
                ToolbarItem(placement: ToolbarItemPlacement .navigationBarTrailing){
                Button(action: {isDarkModeOn.toggle()}, label: {
                    isDarkModeOn ? Label("Dark", systemImage: "lightbulb.fill") : Label("Dark", systemImage: "lightbulb")
                })
                }
            }
            
        }
        .environment(\.colorScheme, isDarkModeOn ? .dark : .light)
        
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
