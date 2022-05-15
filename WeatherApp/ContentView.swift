//
//  ContentView.swift
//  WeatherApp
//
//  Created by Menaim on 24/01/2022.
//

import SwiftUI

struct ContentView: View {
    // In SwiftUI we can't update the UI directly but we are just telling something else which is this var first to update the UI
    @State private var isDark = false
    // Why @State !? Struct is a value type which means that it doesn't hold the data that's why we are using @state to hold the state

    var body: some View {
        ZStack { // Vertical view heirarchy "Layers" and can only have 10 views inside it
            //            Color(.blue)
            //                .ignoresSafeArea(.all) // modifier but this one is just for normal color and we need to do it as a gradient so we will change it
            
            ///Backgound View
            ///USING Ternary operator
            //BackroundView(mainColor: isDark ? .black : .blue, subColor: isDark ? .gray : Color("skyBlue")) // Go to button to write toggle
            BackroundView(isDark: $isDark) // using $ to indicate this var as a binding var
            
            /// Refactoring again to avoid having all of these vars inside it that's why we will use @Binding
            
//            LinearGradient(gradient: Gradient(colors: [, ), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all) // to ignore the safearea
            
            VStack {
                /// City Text View
                Text("Cairo, Egypt")
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundColor(.white)
                ///add the below parts after adding the spacer()
                    .padding()
                
                ///WeatherStatusView
                VStack (spacing: 4) { /// Add spacing parameter after finishing this vstack code
                    Image(systemName: isDark ? "moon.stars.fill" : "cloud.sun.fill") // will be black so we will use the below modifier
                        .renderingMode(.original)
                        .resizable()
                    /// The below one will be added after .frame
                        .aspectRatio(contentMode: .fit) // Keeps the aspect ratio but still keeping it within 150 x 150 to avoid image being stretched
                        .frame(width: 150, height: 150)
                    Text("76°")
                        .font(.system(size: 50, weight: .semibold, design: .default))
                        .foregroundColor(Color.white)
                    
                    // option + shift + 8
                    /// Options + Ctrl + click to open Text Properties
                    
                }.padding(.bottom, 40)
                
//                Spacer() // Which means that the Vstack is the same length of the screen but at the same time the text is on the top now and the rest of the screen is this spacer
                
                HStack(spacing: 20) {
                    DayVStack(day: "TUE", dayTemperature: 74, imageName:"cloud.sun.fill")
                    DayVStack(day: "WED", dayTemperature: 70, imageName: "sun.max.fill")
                    DayVStack(day: "THU", dayTemperature: 66, imageName: "wind")
                    DayVStack(day: "FRI", dayTemperature: 60, imageName: "sunset.fill")
                    DayVStack(day: "SAT", dayTemperature: 55, imageName: "moon.stars.fill")
                }
                Spacer()
                
                Button {
                    isDark.toggle() // Change the Bool Var the same like -> isDark = !isDark
                    //Don't forget to change the image in the same way with ternary
                } label: {
                    ///ButtonView
                    //Customize button
                    Text("Change Mode")
                        .frame(width: 250, height: 50)
                        .background(.white)
                        .foregroundColor(.blue)
                        .font(.system(size: 30, weight: .semibold, design: .default))
                        .cornerRadius(10.0)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: - DayStackView
struct DayVStack: View {
    var day: String
    var dayTemperature: Int
    var imageName: String
    
    var body: some View {
        VStack {
            Text(day)
                .font(.system(size: 20, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            Text("\(dayTemperature)°")
                .font(.system(size: 30, weight: .semibold, design: .default))
                .foregroundColor(Color.white)
        }
    }
}

//MARK: - Backround View
struct BackroundView: View {
     // Instead of using
    // var mainColor: Color
   // var subColor: Color
   // We will use the below:
    //var isDark: Bool // -> This one should be the same just like the one in the parent so that's why to make sure from that we are using @Binding
    @Binding var isDark: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: isDark ? [.black, .gray] : [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

//MARK: - City Text View
struct CityTextView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

//MARK: - Weather Status View
struct WeatherStatusView: View {
    var weatherTemperature: Int
    var weatherStatusImage: String
    
    var body: some View {
        VStack (spacing: 4) {
            Image(systemName: weatherStatusImage)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            Text("\(weatherTemperature)°")
                .font(.system(size: 50, weight: .semibold, design: .default))
                .foregroundColor(Color.white)
        }.padding(.bottom, 40)
    }
}

//MARK: - Button View
struct ButtonView: View {
    var buttonTitle: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(buttonTitle)
            .frame(width: 250, height: 50)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 30, weight: .semibold, design: .default))
            .cornerRadius(10.0)
    }
}
