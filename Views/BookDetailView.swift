
import SwiftUI

struct BookDetailView: View {
    var book: Books
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Image(book.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300)
            
            Text(book.title)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                Text(book.description)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            HStack(spacing: 20) {
                Button("Open PDF") {
                    if let url = URL(string: book.URL) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        } else {
                            print("Error: Cannot open URL.")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("Color 6"))
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Download PDF") {
                    downloadPDF(from: URL(string: book.URL)!)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("Color 6"))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Button("Return") {
                isPresented = false
            }
            .frame(maxWidth: .infinity)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding()
            .background(Color("Color 4"))
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
        }
        
    }
    

    private func downloadPDF(from url: URL) {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) { location, _, error in
            guard let location = location, error == nil else {
                // Handle error if any
                print("Error downloading PDF: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let fileManager = FileManager.default
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsURL.appendingPathComponent(url.lastPathComponent)

            do {
                try fileManager.moveItem(at: location, to: destinationURL)
                print("PDF file downloaded and saved: \(destinationURL.absoluteString)")
            } catch {
                print("Error saving PDF file: \(error.localizedDescription)")
            }
        }

        downloadTask.resume()
    }
}
