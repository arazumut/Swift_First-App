import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    @State private var userName: String = ""
    @State private var showWelcomeMessage: Bool = false
    @State private var isDarkMode: Bool = false
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle.fill")
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: isDarkMode ? [Color.black, Color.gray] : [Color.blue, Color.purple]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            TabView(selection: $selectedTab) {
                // Home Page
                VStack {
                    Text("Ana Sayfa")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    Spacer()

                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                        )
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)

                    Spacer()

                    Button(action: {
                        withAnimation(.spring()) {
                            showWelcomeMessage.toggle()
                        }
                    }) {
                        Text(showWelcomeMessage ? "Mesajı Gizle" : "Hoşgeldiniz Mesajı Göster")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(15)
                            .padding(.horizontal, 40)
                    }

                    if showWelcomeMessage {
                        Text("Merhaba, \(userName.isEmpty ? "Ziyaretçi" : userName)!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(20)
                            .padding(.horizontal, 40)
                            .transition(.opacity.combined(with: .slide))
                    }

                    Spacer()
                }
                .padding()
                .tag(0)

                // Profile Page
                VStack(spacing: 20) {
                    Text("Profil")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    profileImage?
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 10)

                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text("Profil Fotoğrafını Değiştir")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(15)
                    }

                    TextField("Adınızı Girin", text: $userName)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.horizontal, 50)

                    if !userName.isEmpty {
                        Text("Merhaba, \(userName)!")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(20)
                            .padding(.horizontal, 40)
                            .transition(.move(edge: .bottom))
                    }

                    Spacer()
                }
                .padding()
                .tag(1)
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
                }

                // Settings Page
                VStack(spacing: 20) {
                    Text("Ayarlar")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    Toggle(isOn: $isDarkMode) {
                        Text("Karanlık Mod")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(20)
                    .padding(.horizontal, 40)

                    Button(action: {
                        userName = ""
                        showWelcomeMessage = false
                        profileImage = Image(systemName: "person.crop.circle.fill")
                        isDarkMode = false
                    }) {
                        Text("Sıfırla")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(15)
                            .padding(.horizontal, 40)
                    }

                    Spacer()
                }
                .padding()
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        .animation(.easeInOut(duration: 0.5), value: isDarkMode)
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    ContentView()
}
