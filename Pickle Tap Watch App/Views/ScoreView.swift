//
//  ContentView.swift
//  PaddlePoints Watch App
//
//  Created by Colten Glover on 6/24/25.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject private var vm = GameViewModel()
    
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
                            Text("\(vm.getOpponentPoints())")
                        }
                        .foregroundStyle(.black)
                        .bold()
                    }
                    .onTapGesture {
                        vm.addPoint(toUser: false)
                    }
                    .onLongPressGesture {
                        vm.subtractPoint(toUser: false)
                    }
                    .foregroundStyle(.red)
                    .sensoryFeedback(.decrease, trigger: vm.game.opponentPoints)
                
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        VStack {
                            Text("You")
                            Text("\(vm.getUserPoints())")
                        }
                        .foregroundStyle(.black)
                    }
                    .onTapGesture {
                        vm.addPoint(toUser: true)
                    }
                    .onLongPressGesture {
                        vm.subtractPoint(toUser: true)
                    }
                    .foregroundStyle(.green)
                    .bold()
                    .sensoryFeedback(.increase, trigger: vm.game.userPoints)
            }
            .padding(.bottom)
            
            Button("Reset") {
                showConfirmReset = true
            }
            .confirmationDialog("Reset scores?",
                                isPresented: $showConfirmReset) {
                Button("Reset", role: .destructive) {
                    vm.resetPoints()
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
