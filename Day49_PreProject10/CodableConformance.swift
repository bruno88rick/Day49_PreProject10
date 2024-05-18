//
//  CodableConformance.swift
//  Day49_PreProject10
//
//  Created by Bruno Oliveira on 18/05/24.
//

import SwiftUI

@Observable
class User: Codable {
    var user = "Taylor"
}

@Observable
class Music: Codable {
    enum CodingKeys: String, CodingKey {
        case _title = "musicTitle"
    }
    var title = "Eu me amarrei"
}

struct CodableConformance: View {
    var body: some View {
        Button("Encode User", action: encodeUser)
            .padding()
        Button("Encode Music", action: encodeMusic)
        
    }
    
    func encodeUser() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        //this will print: {"_name":"Taylor","_$observationRegistrar":{}}
    }
    
    func encodeMusic() {
        let data = try! JSONEncoder().encode(Music())
        let str = String(decoding: data, as: UTF8.self)
        //this will print correct data on JSON format: {"name":"Taylor"}
    }
    
}

#Preview {
    CodableConformance()
}
