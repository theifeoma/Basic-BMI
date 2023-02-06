import SwiftUI

struct ContentView: View {
    @State private var weightText: String = "00"
    @State private var heightText: String = "1.0"
    
    @State var bmiText: String = ""
    @State var bmiDetail: String = ""
    @State var bmiString: String = ""
    
    @State var showAlert: Bool = false
    
    @State var height: Float = 0.0
    @State var weight: Float = 0.0
    @State var isChanged = false
    
    var body: some View{
        ZStack{
            VStack{
                VStack{
                    //Title rendering section
                    VStack{
                        Text("BMI Calculator")
                            .font(.title)
                            .padding(.top)
                            .foregroundColor(Color.blue)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                        .background(Color.black)
                        .shadow(radius: 10)
                    
                    //Textfields rendering and sliders
                    VStack{
                        TextField("Enter height in meters - 1.75" , text: $heightText)
                            .padding(.all)
                            .frame(width: 300)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.clear)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                            .keyboardType(.decimalPad)
                            .onChange(of: heightText){ value in calculateBMI()}
                        Slider(value: $height, in: 1...2, onEditingChanged: { _ in if self.isChanged == false { self.isChanged = true}

                            heightText = String(format: "%.2f",height)
                        })
                        .accentColor(Color("purpleDark"))
                        .padding()
                        
                        
                        TextField("Enter weight kilograms - 100" , text: $weightText)
                            .padding(.all)
                            .frame(width: 300)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.clear)
                            .foregroundColor(.black)
                            .shadow(radius: 5)
                            .keyboardType(.decimalPad)
                            .onChange(of: heightText){ value in calculateBMI()}
                        Slider(value: $height, in: 1...2, onEditingChanged: { _ in if self.isChanged == false { self.isChanged = true}

                            heightText = String(format: "%.2f",height)
                        })
                        .accentColor(Color("purpleDark"))
                        .padding()

                    }
                    
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    
                    //Results section
                    VStack{
                        Text(bmiText)
                            .font(.title)
                            .foregroundColor(Color.black)
                        Text(bmiString)
                            .font(.largeTitle)
                            .foregroundColor(Color.black)
                        Text(bmiDetail)
                            .padding()
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .padding()
                }
                
                //Button views
                HStack{
                    Button{
                        calculateBMI()
                    }
                label:{
                    HStack{
                        Text("Calculate BMI")
                            .padding()
                            .foregroundColor(Color(.white))
                            .background(Color.blue)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.title)
                    .padding(.horizontal, 60.0)
                    .padding(.vertical, 20)
                    .background(Color("button"))
                    .cornerRadius(10)
                    .foregroundColor(Color.black)
                    .shadow(radius: 5)
                    .padding(.vertical, 40)
                    .padding(.horizontal, 20)
                }
                    //Spacer()
                    //._automaticPadding()
                .alert( isPresented: $showAlert) {
                    Alert(title: Text("Invalid Data"), message: Text("Non-numeric data or missing data"), dismissButton: .default(Text("Try Again")))
                }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
        .background(Color.mint)
    }
    //Validation and calculation
    func calculateBMI(){
        if self.heightText == "" || self.weightText == "" {
            self.showAlert = true
            return
        }
        
        let numberPattern = #"^\d{1,5}|d{0,5}\.\d{1,2}$"#
        let result = self.heightText.range(of: numberPattern, options: .regularExpression)
        let validHeight = (result != nil)
        if (!validHeight){
            self.showAlert = true
            return
        }
        let heightInMeters = Double(self.heightText)
        
        let weightInKg = Double(self.weightText)
        let heightSqM = pow(heightInMeters!, 2)
        let bmis = weightInKg!/heightSqM
        let bmi2dp = Double(round(100 * bmis) / 100)
        self.bmiString = " \(bmi2dp)"
        
        self.bmiText = "Your BMI is"
        
        if bmis > 30{
            self.bmiDetail = "You are considered to be obese."
        }
        else if bmis > 25{
            self.bmiDetail = "You are considered to be overweight."
        }
        else if bmis < 16{
            self.bmiDetail = "You are underweight"
        }
        else{
            self.bmiDetail = "You are healthy!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
