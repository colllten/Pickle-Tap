//
//  InformationSheet.swift
//  Pickle Tap Watch App
//
//  Created by Colten Glover on 6/25/25.
//

import SwiftUI

struct InformationSheet: View {
    var body: some View {
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

#Preview {
    InformationSheet()
}
