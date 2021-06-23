//
//  H21Widget.swift
//  H21Widget
//
//  Created by Lisita Evgheni on 23.06.21.
//

import WidgetKit
import SwiftUI
import Intents


struct HabitEntry: TimelineEntry {
    let date = Date()
    let habits: [Habit]
    
}

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> HabitEntry {
        HabitEntry(habits: [Habit.demoHabit])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (HabitEntry) -> Void) {
        completion(HabitEntry(habits: [Habit.demoHabit]))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<HabitEntry>) -> Void) {
        
        let viewModel = HabitsViewModel()
        viewModel.loadHabits() {
            WidgetCenter.shared.reloadAllTimelines()
        }
        
        let entries = [HabitEntry(habits: viewModel.habits)]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)

    }
}

//struct Provider: IntentTimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
//    }
//
//    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration)
//        completion(entry)
//    }
//
//    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationIntent
//}
//
struct HabitRowShort: View {
    @EnvironmentObject var habitsModel: HabitsViewModel
    var habit: Habit
    
    var body: some View {
        let (_, icon) = habitsModel.progress(for: habit).toUI()
        
        return
            VStack(spacing: 0) {
                HStack {
                    Text(habit.title)
                        .font(.title3)
                    Spacer()
                    
                    Badge(color: habit.color) {
                        Image(systemName: icon)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                
            }
    }
}

struct HabitRowLarge: View {
    @State var enabledAchievements = Array(repeating: false, count: 6)
    @EnvironmentObject var habitsModel: HabitsViewModel
    var habit: Habit
    
    var body: some View {
        let (_, icon) = habitsModel.progress(for: habit).toUI()
        
        return
            VStack(spacing: 0) {
                HStack {
                    Checkbox(isChecked: $enabledAchievements[0], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[1], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[2], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[3], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[4], color: habit.color)
                        .frame(maxWidth: .infinity)
                    Checkbox(isChecked: $enabledAchievements[5], color: habit.color)
                        .frame(maxWidth: .infinity)
                }
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 10))
                HStack {
                    Text(habit.title)
                        .font(.title3)
                    Spacer()
                    
                    Badge(color: habit.color) {
                        Image(systemName: icon)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                
            }
    }
}


struct H21WidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemMedium:
            VStack{
                ForEach(entry.habits, id: \.id) { habit in
                    HabitRowShort(habit: entry.habits[0]).environmentObject(HabitsViewModel())
//                        .padding()
                }
                Spacer()
            }
            
        case .systemLarge:
            VStack{
                Days()
                ForEach(entry.habits, id: \.id) { habit in
                    HabitRowLarge(enabledAchievements: habit.enabledAchievements, habit: habit).environmentObject(HabitsViewModel())
                        .padding()
                    
                }
                Spacer()
            }
            .padding()
        default:
            HabitRowShort(habit: entry.habits[0]).environmentObject(HabitsViewModel())
        }
        
    }
}

@main
struct H21Widget: Widget {
    let kind: String = "H21Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            H21WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct H21Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            H21WidgetEntryView(entry: HabitEntry(habits: [Habit.demoHabit, Habit.demoHabit, Habit.demoHabit,])
            )
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
        Group {
            H21WidgetEntryView(entry: HabitEntry(habits: [Habit.demoHabit, Habit.demoHabit, Habit.demoHabit,])
            )
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }

    }
}
