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
    @State var isSelectedChouHan = false
    @State var isChou = false
    @State var chouHanTitle = "丁半決めてね"
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isChou = true
                    isSelectedChouHan = true
                    chouHanTitle = "準備完了"
                    
                 }) {
                     Text("丁")
                         .font(.largeTitle)
                         .foregroundColor(switchLabel(color: isChou))
                 }
                 .padding(50)
                Button(action: {
                    isChou = false
                    isSelectedChouHan = true
                    chouHanTitle = "準備完了"
                 }) {
                     Text("半")
                         .font(.largeTitle)
                         .foregroundColor(switchLabel(color: isChou))
                 }
                 .padding(50)
            }
            Spacer()
            Label(chouHanTitle, systemImage: "scissors")
                .labelStyle(.titleOnly)
                .font(.largeTitle)
                .foregroundColor(.black)
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
                     .foregroundColor(.black)
                     .disabled(isSelectedChouHan)
             }
             .disabled(isRolling)
             
        }
        .padding()
    }
}

// MARK: - Private

private extension ContentView {
    
    func switchLabel(color: Bool) -> Color {
        let color: Color = color ? .red : .black
        return color
    }
    
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
            chouHanTitle = setResult(title: isOddNumber())
        }
    }
    
    func stopRandamNumber() -> Int {
        return Int.random(in: 1..<7)
    }
    
    func isOddNumber() -> Bool {
        let sum = leftDiceNumber + rightDiceNumber
        return sum % 2 == 0
    }
    
    func setResult(title: Bool) -> String {
        return title ? "丁" : "半"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
