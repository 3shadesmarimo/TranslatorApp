//
//  ContentView.swift
//  Translator
//
//  Created by Bilegt Davaa on 2023-03-15.
//  And Nav

import SwiftUI

struct ContentView: View {
    @State var textfieldText: String = ""
    @State var textfieldText2 : String = ""
    @State var selectedOption = 0
    @State var selectedOption2 = 0
    
    let options = ["English", "French", "Spanish", "Chinese"]
    let options2 = ["English", "French", "Russia", "Chinese"]
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                HStack{
                    Text("From:")
                        .font(.title3)
                    Spacer().frame(width: 250)
                    Text("To:")
                        .font(.title3)
                }
                
                HStack {
                         
                        
                    Picker(selection: $selectedOption, label: Text("Select language")){
                        ForEach(0..<options.count){
                            index in Text(options[index]).tag(index)
                        }
                        .frame(height: 50)
                    }
                    Spacer().frame(width: 150)
                    Picker(selection: $selectedOption2, label: Text("Select language")){
                        ForEach(0..<options2.count){
                            index in Text(options2[index]).tag(index)
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
                
                Spacer().frame(height: 40)
                    
                
                Button(action: {
                    
                }, label: {
                    Text("Translate")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.cornerRadius(10))
                        .foregroundColor(.white)
                })
            }
            .padding()
            .navigationTitle("Translator App")
        }
        
        
       
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
