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
            infoHeader
            
            HStack {
                pointsView(for: "Opponent")
                pointsView(for: "You")
            }
            .padding(.bottom)
            
            resetButton
                .frame(maxWidth: 100)
                .frame(maxHeight: 30)
                .padding(.top)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
                                
        }
        .ignoresSafeArea()
        .sheet(isPresented: $showSheet) {
            InformationSheet()
        }
    }
    
    private var infoHeader: some View {
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
    }
    
    private func pointsView(for player: String) -> some View {
        let points = player == "You" ? vm.getUserPoints() : vm.getOpponentPoints()
        let colors = player == "You" ? [Color.green, Color.white] : [Color.red, Color.white]
        
        return RoundedRectangle(cornerRadius: 10)
            .fill((player == "You" ? Color.green : Color.red).opacity(0.8)) // Light background
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(player == "You" ? Color.green : Color.red, lineWidth: 3)
            )
            .overlay {
                VStack {
                    Text(player)
                    Text("\(points)")
                }
                .foregroundStyle(Color.black)
                .bold()
            }
            .onTapGesture {
                vm.addPoint(toUser: player == "You")
            }
            .onLongPressGesture {
                vm.subtractPoint(toUser: player == "You")
            }
            .sensoryFeedback(player == "You" ? .increase : .decrease, trigger: points)
    }

    
    private var resetButton: some View {
        Button("Reset") {
            showConfirmReset = true
        }
        .confirmationDialog("Reset scores?",
                            isPresented: $showConfirmReset) {
            Button("Reset", role: .destructive) {
                vm.resetPoints()
            }
        }
    }
}

#Preview {
    ScoreView()
}
