//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jonathan Avila on 10/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var numberquestion = 0
    @State var score = 0
    @State private var showingScore = false
    @State private var showingResetGame = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    func getScoreMessage(_ number: Int) {
        scoreMessage = "That's the flag of \(countries[number]), your score is \(score)"
    }
    
    func resetGame(){
        if numberquestion == 8{
            numberquestion = 0
            score = 0
        }
    }
    
    func flagTapped(_ number: Int) {
        numberquestion += 1
        scoreTitle = (number == correctAnswer) ? "Correct" : "Wrong"
        
        if number == correctAnswer {
            score += 1
        }
        
        getScoreMessage(number)
        
        showingResetGame = (numberquestion == 8)
        showingScore = !showingResetGame
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 15) {
                    Spacer()
                    
                    Text("Guess the Flag")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    
                    
                    VStack(spacing: 15) {
                        Text("Tap the flag of").foregroundColor(.white).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                            }
                        }
                        .rotationEffect(Angle(selected))
                    }.frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("number of question \(numberquestion)")
                        .foregroundColor(.white)
                        .font(.subheadline.bold())
                    Spacer()
                    Text("Score \(score)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    Spacer()
                }
                .padding()
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game has finished",isPresented: $showingResetGame){
            Button("Reset Game", action: resetGame)
        } message: {
            Text("Congratulations, your score was \(score)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
