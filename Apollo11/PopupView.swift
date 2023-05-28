//
//  PopupView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/26.
//

import SwiftUI
import PopupView
import ComposableArchitecture

struct PopupReducer: ReducerProtocol {
  
  struct State: Equatable {
    var title: String?
    var text: String?
    var image: String?
  }
  
  enum Action {
    
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      return .none
    }
  }
}

struct PopupView: View {
  
  let store: StoreOf<PopupReducer>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      ZStack {
          RoundedRectangle(cornerRadius: 12)
          .fill(Color.red)
          
          HStack(spacing: 0) {
              Image("avatar1")
                  .aspectRatio(1.0, contentMode: .fit)
                  .cornerRadius(16)
                  .padding(16.0)
              
              VStack(alignment: .leading, spacing: 8) {
                  Group {
                      Text("Adam Jameson")
                          .bold()
                          .foregroundColor(.black) +
                      Text(" invites you to join his training")
                          .foregroundColor(.black.opacity(0.6))
                  }
                  
                  Button {
                      debugPrint("Accepted!")
                  } label: {
                      Text("Accept".uppercased())
                          .font(.system(size: 14, weight: .black))
                  }
                  .buttonStyle(.borderedProminent)
              }
              
              Spacer()
          }
      }
      .frame(height: 98)
      .padding(.horizontal, 16)
    }
  }
  
}
