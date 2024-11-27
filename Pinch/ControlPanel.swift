//
//  ControlPanel.swift
//  Pinch
//
//  Created by milad marandi on 11/26/24.
//

import SwiftUI

struct ControlPanel: View {
    
    @Binding var scale:CGFloat
    @Binding var Offset:CGSize
    
    var body: some View {
        HStack(spacing:20){
            Button {
                if scale > 1 {
                    scale -= 1
                }
                
            } label: {
                Image(systemName: "minus.magnifyingglass")
                    .resizable()
                    .frame(width: 35, height: 35, alignment: .center)
            }
            
            
            Button {
                scale = 1
                Offset = .zero
            } label: {
                Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                    .resizable()
                    .frame(width: 35, height: 35, alignment: .center)
            }
            Button {
                if scale < 5{
                    scale += 1
                }
                
            } label: {
                Image(systemName: "plus.magnifyingglass")
                    .resizable()
                    .frame(width: 35, height: 35, alignment: .center)
            }
    
        }
        .tint(.black)
        .padding()
        .font(.footnote)
        .background(Color.gray.opacity(0.5))
        .clipShape(.rect(cornerRadius: 10))
        
    }
}

#Preview {
    ControlPanel(scale: .constant(1), Offset: .constant(.zero))
}
