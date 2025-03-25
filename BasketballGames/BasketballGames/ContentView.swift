//
//  ContentView.swift
//  BasketballGames
//
//  Created by Samuel Shi on 2/27/25.
//

import SwiftUI

struct Game: Codable {
    var isHomeGame: Bool
    var opponent: String
    var score: Score
    var team: String
    var id: Int
    var date: String
}

struct Score: Codable {
    var opponent: Int
    var unc: Int
}

struct ContentView: View {
    @State var games = [Game]()
    var body: some View {
        VStack {
            List(games, id: \.id) { game in
                Text("Opponenet: \(game.opponent)")
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://api.samuelshi.com/uncbasketball") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Game].self, from: data) {
                games = decodedData
            } else {
                print("error")
            }
        } catch {
            print("invalid")
        }
                
    }
}

#Preview {
    ContentView()
}
