//
//  ContentView.swift
//  Translator
//
//  Created by Bilegt Davaa on 2023-03-15.
//  And Nav hehe

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    
    let translator = Translator(key: "714c72d008d74750aecaafdda23d58ee", endpoint: "https://api.cognitive.microsofttranslator.com", location: "westus2")
    
    @State var textfieldText: String = ""
    @State var textfieldText2 : String = ""
    @State var selectedOption = "en"
    @State var selectedOption2 = "en"
    
    
    let options = ["ar","en", "fr", "es", "pa", "ro", "mn", "ru", "uk", "ja", "hi", "el", "zh-Hans"]
    let options2 = ["ar","en", "fr", "es", "pa", "ro", "mn", "ru", "uk", "ja", "hi", "el", "zh-Hans"]
    
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
                        ForEach(options, id: \.self){ option in
                            Text(option)
                            
                            
                        }
                        .frame(height: 50)
                    }
                    
                    
                    Spacer().frame(width: 150)
                    
                    
                    Picker(selection: $selectedOption2, label: Text("Select language")){
                        ForEach(options2, id :\.self){ option in Text(option)
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
                    translator.translate(text: textfieldText, from: selectedOption, to: [selectedOption2]) { result, error in
                        DispatchQueue.main.async {
                            if let result = result {
                                textfieldText2 = result
                            } else{
                                textfieldText2 = "Translation failed. Please try again."
                            }
                        }
                        
                    }
                    
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
            .toolbar{
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
