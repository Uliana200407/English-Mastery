//
//  MagazineView.swift
//  English Mastery
//
//  Created by mac on 08.07.2023.
//

import SwiftUI

struct MagazineView: View {
    @State private var activeTag: String = "Biography"
    @Namespace private var animation
    @State private var isBookWindowPresented = false
    @State private var selectedBookIndex: Books? = nil

    var body: some View {
        NavigationView {
            
            VStack(spacing: 15){
                HStack{
                    Text("Search |")
                        .font(.largeTitle.bold())
                    Text ("Recommended" )
                        .fontWeight (.semibold)
                        .padding (.leading, 15) . foregroundColor (Color("Color 4")) .offset (y: 2)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal,15)
                
                TagsView()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(BuiltInBooks) {
                            BookCardView($0)
                            
                        }
                    }
                    .padding (.horizontal, 79)
                    .padding (.vertical,20)
                }
                    .coordinateSpace (name: "SCROLLVIEW")
                    .padding (.top, 15)
                
            }
            
            .navigationBarTitle("", displayMode: .large)
        }
    }
    @ViewBuilder
    func BookCardView(_ book: Books) -> some View {
        GeometryReader { geometry in
            let size = geometry.size
            let rect = geometry.frame(in: .named("SCROLLVIEW"))
            let minY = rect.minY
            
            HStack(spacing: 0) {
                GeometryReader { imageGeometry in
                    Image(book.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageGeometry.size.height, height: imageGeometry.size.height)
                        .clipped()
                }
                .frame(width: size.height * 0.6)
               
                VStack(alignment: .leading, spacing: 5) {
                    Text(book.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("By \(book.author)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .italic()
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    RatingView(rating: book.rating)
                    HStack (spacing: 4) {
                        Text(String(format: "%d", book.bookYear))
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Color 4"))
                        
                        Text("Year")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Image(systemName: "chevron.right")
                               .font(.headline)
                               .foregroundColor(.white)
                               .frame(width: 20, height: 20)
                               .background(Color("Color 4"))
                               .clipShape(Circle())
                               .onTapGesture {
                                   isBookWindowPresented = true
                                   selectedBookIndex = book
                               }
                               .sheet(isPresented: $isBookWindowPresented, content: {
                                   if let book = selectedBookIndex {
                                       BookDetailView(book: book, isPresented: $isBookWindowPresented)
                                   }
                               })

                    
                    Spacer()
                }
                .padding(.leading, 20)
                .frame(width: size.height * 0.5)
                .background(Color("Color 6"))
                .cornerRadius(10)
                .shadow(radius: 5)
                .zIndex(1)
                
            }
            .frame(width: size.width)
            .rotation3DEffect(.init(degrees: convertOffsetToRotation(rect)), axis: (x: 1,y:0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
        }
        .frame(height: 240)
    }
      
    func convertOffsetToRotation(_ rect: CGRect) -> Double {
        let cardHeight = rect.height
        let minY = rect.minY - 20
        let progress = minY < 0 ? (minY / cardHeight) : 0
        let constrainedProgress = min(-progress, 1.0)
        return constrainedProgress * Double(90)
    }

    @ViewBuilder
    func TagsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 10) {
                ForEach (tags, id: \.self) { tag in
                    Text(tag)
                        .font (.caption)
                        .padding (.horizontal, 12)
                        .padding (.vertical, 5)
                        .background {
                            if activeTag == tag {
                                Capsule()
                                    .fill(Color("Color"))
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            } else {
                                Capsule()
                                    .fill(Color("Color 6").opacity(0.3))
                            }
                        }
                        .foregroundColor (activeTag == tag ? .white : .black)
                        .bold()
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.4, dampingFraction:0.7, blendDuration: 0.7)){
                                activeTag = tag
                            }
                        }
                }
                
            }
            .padding(.horizontal,15)
        }
    }
}
struct RatingView: View {
    var rating: Int
    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...5, id: \.self) { index in
                Image (systemName: "book.fill")
                    . font (.caption2)
                    . foregroundColor (index <= rating ? Color("Color") : .gray.opacity(0.5))
            }
            Text("(\(rating))")
                .font(.caption)
            .fontWeight(.bold)                .foregroundColor(Color("Color"))
                .padding (.leading, 5)
        }
    }
}
var tags:[String]=[
    "History","Classical","Biography","Det ective","Adventure","Fairy Tales","Fantasy","Cartoon",
]
struct MagazineView_Previews: PreviewProvider {
    static var previews: some View {
        MagazineView()
    }
}
