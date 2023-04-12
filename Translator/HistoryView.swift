//
//  HistoryView.swift
//  Translator
//
//  Created by Bilegt Davaa on 2023-04-12.
//

import SwiftUI

struct HistoryView: View {
    var translations: [(fromText: String, toText: String)]
    @Binding var textfieldText: String
    @Binding var textfieldText2: String
    
    var body: some View {
        List(translations.indices, id: \.self) { index in
            Button(action: {
                textfieldText = translations[index].fromText
                textfieldText2 = translations[index].toText
            }) {
                HStack {
                    Text(translations[index].fromText)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(translations[index].toText)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(translations: [], textfieldText: .constant(""), textfieldText2: .constant(""))
    }
}
