//
//  ContentView.swift
//  ChouHan
//
//  Created by 滝野翔平 on 2023/02/25.
//

import SwiftUI

struct ContentView: View {
    @State var leftDiceNumber = 1
    @State var rightDiceNumber = 6
    @State var timer: Timer?
    @State var isRolling = false
    @State var isChou = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isChou = true
                 }) {
                     Text("丁")
                         .font(.largeTitle)
                         .foregroundColor(Color.black)
                 }
                 .padding(50)
                Button(action: {
                    isChou = false
                 }) {
                     Text("半")
                         .font(.largeTitle)
                         .foregroundColor(Color.black)
                 }
                 .padding(50)
            }
            Spacer()
            HStack {
                Image(systemName: "die.face.\(leftDiceNumber)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 3)
                        .padding()
                    .foregroundColor(.black)
                Image(systemName: "die.face.\(rightDiceNumber)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 3)
                    .padding()
                    .foregroundColor(.black)
            }
            Spacer()
            Button(action: {
                playChouHan()
             }) {
                 Text("ChouHan!!!")
             }
             .disabled(isRolling)
        }
        .padding()
    }
}

// MARK: - Private

private extension ContentView {
    
    func playChouHan() {
        isRolling = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            leftDiceNumber = stopRandamNumber()
            rightDiceNumber = stopRandamNumber()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            timer?.invalidate()
            timer = nil
            isRolling = false
            
        }
    }
    func stopRandamNumber() -> Int {
        return Int.random(in: 1..<7)
    }
    
    func isOddNumber() -> Bool {
        var sum = leftDiceNumber + rightDiceNumber
        return sum / 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
