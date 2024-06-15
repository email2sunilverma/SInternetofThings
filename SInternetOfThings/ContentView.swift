//
//  ContentView.swift
//  SInternetOfThings
//
//  Created by Sunil Verma on 15/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Connect") {
                SiOTManager.shared.connectDevice()
            }
            
            Button("Connect Device") {
               let device =  SIOTDevice(clientId: "", host: "", post: 1843)
                SiOTManager.shared.connectDevice(device: device)
                
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
