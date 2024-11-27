//
//  ContentView.swift
//  Pinch
//
//  Created by milad marandi on 11/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var ImageScale:CGFloat = 1
    @State var Imageoffset:CGSize = CGSize(width: 0, height: 0)
    @State var isDrawerOpen:Bool = true
    @AppStorage("Ima") var PageIndex:Int = 2
    @State var isAnimating:Bool = false
    
    private func ResetImage() {
        ImageScale = 1
        Imageoffset = .zero
    }
    
    var body: some View {
       
        NavigationView {
            
            ZStack{
                Color.clear

                Image(pageData[PageIndex - 1].imagName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 10))
                    .offset(x: Imageoffset.width, y: Imageoffset.height)
                    .scaleEffect(ImageScale)
                    .animation(.easeInOut(duration: 0.5), value: ImageScale)
                    .animation(.linear(duration: 0.5), value: Imageoffset)
                    .padding()
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeIn, value: isAnimating)
                    .animation(.easeIn(duration: 0.2), value: PageIndex)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                let translation = value.translation
                                self.Imageoffset = translation
                            })
                            .onEnded({ value in
                                if ImageScale <= 1{
                                    ResetImage()
                                }
                            })
                    )
                
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                
                                if ImageScale >= 1 && ImageScale <= 5 {
                                    ImageScale = value.magnitude
                                }
                            })
                        
                            .onEnded({ value in
                                if ImageScale > 5 {
                                    ImageScale = 5
                                }
                                else if ImageScale <= 1 {
                                    ResetImage()
                                }
                            })
                    )
                    .onTapGesture(count: 2, perform: {
                        if ImageScale <= 1{
                            ImageScale = 5

                        }
                        else {
                            ResetImage()
                        }
                    })
                    
                
            }
            .onAppear(perform: {
                isAnimating = true
            })

            .ignoresSafeArea()
            .preferredColorScheme(.dark)
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .overlay(alignment: .top, content: {
                InfoPanel(scale: ImageScale, Offset: Imageoffset)
                    .padding()
            })
            .overlay(alignment:.bottom) {
                ControlPanel(scale: $ImageScale, Offset: $Imageoffset)
                    .padding(.bottom , 45)
            }
            
            .overlay(alignment:.topTrailing) {
                HStack(spacing: 12){
                    Image(systemName: isDrawerOpen ? "chevron.forward" :"chevron.backward" )
                        .resizable()
                        .scaledToFit()
                        .frame(height:40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            withAnimation(.easeOut, {
                                isDrawerOpen.toggle()
                            })
                        
                        }
                    ForEach(pageData){ data in
                        Image(data.imagName)
                            .resizable()
                            .scaledToFit()
                            .frame(width:80)
                            .clipShape(.rect(cornerRadius: 8))
                            .shadow(radius:4)
                            .onTapGesture {
                                
                                PageIndex = data.id
                            }
                            
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 12))
                .frame(width: 260)
                .offset(x: isDrawerOpen ? 20 : 210)
                .padding(.top , UIScreen.main.bounds.height / 12)
            }
            
        }
    
        
        
    }
}

#Preview {
    ContentView()
}
