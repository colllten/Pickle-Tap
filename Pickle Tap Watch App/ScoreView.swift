//
//  ContentView.swift
//  PaddlePoints Watch App
//
//  Created by Colten Glover on 6/24/25.
//

import SwiftUI

struct ScoreView: View {
    @State var userPoints = 0
    @State var oppPoints = 0
    @State var showSheet = false
    @State var showConfirmReset = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "info.circle")
                    .frame(maxHeight: 20)
                    .frame(maxWidth: 65, alignment: .leading)
                    .background()
                    .onTapGesture {
                        showSheet = true
                    }
                
                Spacer()
            }
            .padding([.top, .leading])
            .padding([.top, .leading])
            
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        VStack(alignment: .center) {
                            Text("Opponent")
                            Text("\(oppPoints)")
                        }
                        .foregroundStyle(.black)
                        .bold()
                    }
                    .onTapGesture {
                        oppPoints += 1
                    }
                    .onLongPressGesture {
                        if oppPoints > 0 {
                            oppPoints -= 1
                        }
                    }
                    .foregroundStyle(.red)
                    .sensoryFeedback(.decrease, trigger: oppPoints)
                
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        VStack {
                            Text("You")
                            Text("\(userPoints)")
                        }
                        .foregroundStyle(.black)
                    }
                    .onTapGesture {
                        userPoints += 1
                    }
                    .onLongPressGesture {
                        if userPoints > 0 {
                            userPoints -= 1
                        }
                    }
                    .foregroundStyle(.green)
                    .bold()
                    .sensoryFeedback(.increase, trigger: userPoints)
            }
            .padding(.bottom)
            
            Button("Reset") {
                showConfirmReset = true
            }
            .confirmationDialog("Reset scores?",
                                isPresented: $showConfirmReset) {
                Button("Reset", role: .destructive) {
                    userPoints = 0
                    oppPoints = 0
                }
            }
                                .frame(maxWidth: 100)
                                .frame(maxHeight: 30)
                                .padding(.top)
                                .padding(.bottom)
                                .padding(.bottom)
                                .padding(.bottom)
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showSheet) {
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        Text("Tap ")
                            .bold()
                        +
                        Text("to add 1 point to your score or the opponent's")
                    }
                    .padding(.bottom)
                    
                    Group {
                        Text("Long press ")
                            .bold()
                        +
                        Text("to take one point away from either score")
                    }
                    .padding(.bottom)
                    
                    Group {
                        Text("Reset ")
                            .bold()
                        +
                        Text("to reset both scores to 0")
                    }
                    .padding(.bottom)
                    
                    Group {
                        Text("If using the ")
                        +
                        Text("Workout ")
                            .bold()
                        +
                        Text("app, and you would like to keep Pickle Tap on-screen at all times, change this setting by going to Settings > General > Return to Clock > Workout, and toggle \"Return to App\" off")
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ScoreView()
}
