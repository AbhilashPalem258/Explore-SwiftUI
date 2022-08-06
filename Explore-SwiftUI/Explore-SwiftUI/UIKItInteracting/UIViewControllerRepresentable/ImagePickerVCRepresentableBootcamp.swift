//
//  ImagePickerVCRepresentableBootcamp.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 17/07/22.
//

import Foundation
import SwiftUI

struct ImagePickerVCRepresentableBootcamp: View {
    
    @State var showPickerVC = false
    @State var image: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("Image PickerVC Representable Bootcamp")
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            Button {
                showPickerVC.toggle()
            } label: {
                Text("Open Image Picker")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(.blue)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
        }
        .sheet(isPresented: $showPickerVC) {
            print("Dismissed Picker VC")
        } content: {
            ImagePickerVCRepresentable(image: $image, showPickerVC: $showPickerVC)
        }
    }
}

struct ImagePickerVCRepresentableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerVCRepresentableBootcamp()
    }
}

struct ImagePickerVCRepresentable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var showPickerVC: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(image: $image, showPickerVC: $showPickerVC)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var showPickerVC: Bool
        
        init(image: Binding<UIImage?>, showPickerVC: Binding<Bool>) {
            self._image = image
            self._showPickerVC = showPickerVC
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let img = info[.originalImage] as? UIImage {
                self.image = img
            }
            showPickerVC = false
        }
    }
}
