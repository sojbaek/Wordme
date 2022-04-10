//
//  StatisticsView.swift
//  Wordle
//
//  Created by Songjoon Baek on 3/5/22.
//

import SwiftUI

struct BarGraphView: View {
    var value: Int
    var maxValue: Int
    var highlighted: Bool = false
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment:.trailing){
                RoundedRectangle(cornerRadius: 5)
                    .fill(
                        highlighted ? Color.green : Color.blue
                    )
                Text(String(value)+" ")
            }
            .frame(width: barLength(for: geometry.size))
        }
    }
    
    func barLength(for size: CGSize) -> CGFloat {
        let minWidth:CGFloat = 25.0
        return (maxValue == 0) ? minWidth: minWidth + (size.width-minWidth) * CGFloat(value) / CGFloat(maxValue)
    }
}

struct StatisticsView: View {
    
    var stat: Statistics
    
    let vconfig = [
        GridItem(.fixed(30)),
        GridItem()
    ]
    
    var body: some View {
        let sum = stat.guessDist.max()!
        VStack{
            Text("STATISTICS")
                .font(.footnote)
                .bold()
            HStack(alignment: .top ){
                VStack{
                    Text(String(stat.played))
                        .font(.title)
                    Text("Played")
                        .font(.caption)
                }
                VStack{
                    Text(String(stat.winPercent))
                        .font(.title)
                    Text("Win %")
                        .font(.caption)
                }
                VStack{
                    Text(String(stat.currentStreak))
                        .font(.title)
                    VStack{
                        Text("Current")
                         .font(.caption)
                        Text("Streak")
                         .font(.caption)
                    }
                }
                VStack{
                    Text(String(stat.maxStreak))
                        .font(.title)
                    VStack{
                        Text("Max")
                         .font(.caption)
                        Text("Streak")
                         .font(.caption)
                    }
                }
            }
            Text(" ").font(.title)
            Text("GUESS DISTRIBUTION")
                .font(.footnote)
                .bold()

            LazyVGrid(columns: vconfig, spacing: 10){
                ForEach(1...6, id: \.self) { num in
                    Text(String(num))
                    BarGraphView(value: stat.guessDist[num], maxValue: sum, highlighted: num == stat.lastNumGuess )
                }
            }.padding()
            Spacer()
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(stat: Statistics())
    }
}
