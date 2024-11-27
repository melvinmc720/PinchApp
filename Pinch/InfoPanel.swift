//
//  InfoPanel.swift
//  Pinch
//
//  Created by milad marandi on 11/26/24.
//

import SwiftUI

struct InfoPanel: View {
    
  var scale:CGFloat
   var Offset:CGSize
    
    @State var isPanelVisible:Bool = false
    
    
    var body: some View {
        HStack{
            Image(systemName:"circle.circle")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .onLongPressGesture(minimumDuration: 0.5) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isPanelVisible.toggle()
                    }
                   
                }
            Spacer()
            
            HStack(spacing:2){
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(Offset.width)")
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(Offset.height)")
                Spacer()
            }
            
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 5))
            .frame(maxWidth:420)
            .opacity(isPanelVisible ? 1 : 0)
            Spacer()
            
        }
        
    }
}

#Preview {
    InfoPanel(scale: 1, Offset: .zero)
        .preferredColorScheme(.dark)
}
