//
//  ContentView.swift
//  AnimatingGestures
//
//  Created by Jonathan Avila on 26/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    let letters = Array("Hello SwiftUI")
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
        
        VStack {
            LinearGradient(colors: [.red,.yellow], startPoint: .topLeading, endPoint: .bottomLeading)
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(DragGesture().onChanged{
                    dragAmount = $0.translation
                }.onEnded({ _ in
                    withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)){
                        dragAmount = .zero}}))
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
