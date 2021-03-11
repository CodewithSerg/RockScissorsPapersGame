//
//  ContentView.swift
//  SimpleGameMVVM
//
//  Created by Sergey Antoniuk on 11/29/20.
//

import SwiftUI



//View
struct ContentView: View {
    
    @ObservedObject var viewModel = GameViewModel()
    
    var body: some View {
        VStack{
            ZStack{
                Color.purple
                VStack{
                Text("Player 2")
                Spacer()
                Text(viewModel.getFinalMove(forPlayer: .two))
                Spacer()
                Text(viewModel .getStatusText(forPlayer: .two))
                HStack{
                    ForEach(viewModel .getAllowedMoves(forPlayer: .two), id: \.self ){ move in
                        Button(action:{
                            self.viewModel .choose(move, forPlayer: .two)
                        }){
                            Spacer()
                            Text(move.rawValue)
                            Spacer()
                        }
                    }
                }
                }.padding(.bottom, 40)
            }.rotationEffect(.init(degrees: 180))
            
            
            //Todo: Retry
            if viewModel.isGameOver(){
                Button(action: {self.viewModel.resetGame()}, label: {
                    Text("Retry 🔄")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.custom("AvenirNext-UltraLight-Bold", size: 30))
                })
            }
            
            ZStack{
                Color.blue
                VStack{
                    Text("Player 1")
                    Spacer()
                    Text(viewModel.getFinalMove(forPlayer: .one))
                    Spacer()
                    Text(viewModel .getStatusText(forPlayer: .one))
                    HStack{
                        ForEach(viewModel .getAllowedMoves(forPlayer: .one), id: \.self ){ move in
                            Button(action:{
                                self.viewModel .choose(move, forPlayer: .one)
                            }){
                                Spacer()
                                Text(move.rawValue)
                                Spacer()
                            }
                        }
                    }
                }.padding(.bottom, 40)
                
            }
        }
        .foregroundColor(.white)
        .font(.custom("AvenirNext-UltraLight", size: 80))
        .edgesIgnoringSafeArea([.bottom, .top])
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

