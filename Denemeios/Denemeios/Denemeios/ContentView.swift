import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    @State private var userName: String = ""
    @State private var showWelcomeMessage: Bool = false

    var body: some View {
        ZStack {
            // Arka planı tüm ekran boyunca genişlet
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple, Color.orange]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea() // Safe area'yı ihmal ederek tüm ekranı doldur

            TabView(selection: $selectedTab) {
                // Ana Sayfa
                VStack {
                    VStack(spacing: 10) {
                        Text("Ana Sayfa")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.headline)

                        Text("SwiftUI ile dinamik sayfa örneği")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 60)

                    Spacer(minLength: 20)

                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.blue))
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

                    Spacer()

                    Button(action: {
                        withAnimation {
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
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(15)
                            .padding(.horizontal, 40)
                            .transition(.slide)
                    }

                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                           startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea())
                .tag(0)

                // Profil Sayfası
                VStack(spacing: 20) {
                    Text("Profil")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.pink))
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

                    TextField("Adınızı Girin", text: $userName)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .padding(.horizontal, 50)

                    Text("İsminizi girerek burada mesajınızı görebilirsiniz")
                        .fontWeight(.bold)

                    if !userName.isEmpty {
                        Text("Merhaba, \(userName)!")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(15)
                            .padding(.horizontal, 40)
                    }

                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.orange]),
                                           startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea())
                .tag(1)

                // Ayarlar Sayfası
                VStack(spacing: 20) {
                    Text("Ayarlar")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Toggle(isOn: $showWelcomeMessage) {
                        Text("Hoşgeldiniz Mesajını Göster")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(15)
                    .shadow(radius: 30)
                    .padding(.horizontal, 40)
                    

                    Button(action: {
                        userName = ""
                        showWelcomeMessage = false
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]),
                                           startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea())
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
    }
}

#Preview {
    ContentView()
}
