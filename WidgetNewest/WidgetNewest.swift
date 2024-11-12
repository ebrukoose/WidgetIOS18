//
//  WidgetNewest.swift
//  WidgetNewest
//
//  Created by EBRU KÖSE on 31.10.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> ToDoEntry {
        ToDoEntry(ToDotoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> ToDoEntry {
        ToDoEntry(ToDotoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<ToDoEntry> {
        let entries: [ToDoEntry] = [ToDoEntry(ToDotoDisplay: Array(SharedDatas.shared.toDos.prefix(3)))]
        return Timeline(entries: entries, policy: .after(Date().addingTimeInterval(10)))
    }
}

struct ToDoEntry: TimelineEntry {
    let date: Date = .now
    let ToDotoDisplay: [ToDo]
}

struct WidgetNewestEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("TO DO ITEMS")
                .fontWeight(.bold)
                .padding(.bottom, 5)
            
            VStack {
                if entry.ToDotoDisplay.isEmpty {
                    Text("To dos are completed")
                } else {
                    ForEach(entry.ToDotoDisplay) { toDo in
                        HStack {
                            Button(intent: CompleteToDoIntent(id: toDo.id)){
                                Image(systemName: toDo.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.pink)
                            }.buttonStyle(.bordered)
                            
                            VStack(alignment: .leading) {
                                Text(toDo.name)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .lineLimit(1) // lineLimit doğru şekilde eklendi
                                    .strikethrough(toDo.isCompleted, color: .red)
                                Divider()
                            }
                        }
                    }
                }
            }
        }.containerBackground(.fill.tertiary, for: .widget) // Burada doğrudan uygulandı
    }
}

struct WidgetNewest: Widget {
    let kind: String = "WidgetNewest"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetNewestEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

// Preview Provider kullanarak preview özelliği sağlandı
struct WidgetNewest_Previews: PreviewProvider {
    static var previews: some View {
        WidgetNewestEntryView(entry: ToDoEntry(ToDotoDisplay: Array(SharedDatas.shared.toDos.prefix(3))))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
