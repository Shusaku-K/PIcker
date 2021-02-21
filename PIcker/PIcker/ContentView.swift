//
//  ContentView.swift
//  PIcker
//
//  Created by 金城秀作 on 2021/02/17.
//
//  完成図 割り勘アプリ（下記の3つは入力可能にする）
//  1.支払い総額
//  2.参加者人数
//  3.割り勘の最小単位
//  4.エラーの場合はダイアログボックスで表示させる


import SwiftUI

struct ContentView: View {
    
    // 総支払い金額
    @State private var total = "1010"
    // 人数
    @State private var ninzu = 2
    // 一人当たりの支払い金額
    @State private var kingaku = 0
    // 端数
    @State private var hasu = 0
     // 単位
    @State private var unit = 10
    // 入力にエラーがある場合
    @State private var inputError = false
    // アラートダイアログボックスに表示するメッセージ
    @State private var msg = ""
    
    var body: some View {
        VStack {
            Text("割り勘くん")
                .font(.largeTitle)
            HStack {
                Text("金額: ")
                TextField("000" , text: $total)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                Text("円")
            }
            
            Stepper(value: $ninzu, in: 2...10) {
                Text("人数: \(ninzu)人")
            }
            
            HStack {
                Text("単位: ")
                Picker(selection: $unit, label: Text("最小支払額")) {
                    Text("10円").tag(10)
                    Text("100円").tag(100)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Button(action: {
                self.calc()
            }) {
                Text("計算")
                    .foregroundColor(.black)
                    .background(Capsule()
                                    .foregroundColor(.purple)
                                    .frame(width: 120, height: 35))
        }
            .alert(isPresented: $inputError) {
                //Alert アラートダイアログボックスの表示。msg。
                Alert(title: Text("入力エラー"), message: Text(self.msg),
                      dismissButton: .default(Text("OK")))
                
            
    }
        if kingaku != 0 {
            Text("一人当たりの金額: \(kingaku)円")
            Text("端数: \(hasu)円")
        }
        Rectangle()
            .foregroundColor(.yellow)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
}
    .font(.title)
    .background(Color.orange)
}

// 金額と端数を計算する
func calc() {
    if let totalInt = Int(total) {
        // 単純に人数で割った金額
        let kingakuReal = totalInt / ninzu
        // 10円もしくは100円以下を切り捨てて支払った場合の金額
        kingaku = kingakuReal / unit * unit
        // 端数を計算
        hasu = totalInt - kingaku * ninzu
            if kingaku == 0 {
                msg = "\(unit * ninzu)円以上の金額を入力してください"
                inputError = true
            }
        } else {
            msg = "正しい金額を入力してください"
            inputError = true
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}



