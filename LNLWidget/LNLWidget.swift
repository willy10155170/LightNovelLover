//
//  LNLWidget.swift
//  LNLWidget
//
//  Created by Shiroha on 2022/1/18.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), showing: "test1")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, showing: "test2")
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, showing: testWidget.test())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let showing: String
}

struct LNLWidgetEntryView : View {
    var entry: Provider.Entry
    //@EnvironmentObject var bookDataModel: BookDataModel
    var body: some View {
        VStack {
            Text("今天看過書了嗎？")
        }
//        .onAppear {
//            let container = NSPersistentContainer(name:"BookData")
//            var saveBooks: [LocalBook] = []
//            container.loadPersistentStores { description, error in
//                if let error = error {
//                    print("error \(error)")
//                }
//            }
//            let sort = NSSortDescriptor(key: #keyPath(LocalBook.userOrder), ascending: true)
//            let fetchRequest = NSFetchRequest<LocalBook> (entityName: "LocalBook")
//            fetchRequest.sortDescriptors = [sort]
//            do {
//                saveBooks = try container.viewContext.fetch(fetchRequest)
//            } catch let error {
//                print("error \(error)")
//            }
//            var temp: [LocalBook] = []
//            for i in saveBooks {
//                if i.favoriteRank != -1 {
//                    temp.append(i)
//                }
//            }
//            saveBooks = temp
//            print(saveBooks[0].name!)
//        }
    }
}

@main
struct LNLWidget: Widget {
    let kind: String = "LNLWidget"
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            LNLWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct LNLWidget_Previews: PreviewProvider {
    static var previews: some View {
        LNLWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), showing: "my widget"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

class testWidget {
    static func test() -> String {
        return "test"
    }
}
