//
//  GithubWidgets.swift
//  GithubWidgets
//
//  Created by Kirtan Patel on 12/20/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), contribution: [])
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, contribution: [])
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration, contribution: [])
//            entries.append(entry)
//        }
        
        let poo = UserDataFetcher();
        
        poo.fetchData(user: "kirtanp98") { contributions in
            let entry = SimpleEntry(date: currentDate, configuration: configuration, contribution: contributions)
            entries.append(entry)
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }

    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let contribution: [Contribute]
}

struct GithubWidgetsEntryView : View {
    var entry: Provider.Entry
    
    let columns = [
        GridItem(.fixed(10)),
        GridItem(.fixed(10)),
        GridItem(.fixed(10)),
        GridItem(.fixed(10)),
        GridItem(.fixed(10)),
        GridItem(.fixed(10)),
        GridItem(.fixed(10))
    ]

    var body: some View {
        //Text(entry.date, style: .time)
        LazyHGrid(rows: columns) {
            ForEach(entry.contribution.suffix(133), id: \.date) { item in
                SquareView(contribution: item, colorPalett: Color.testGreen)
                    .animation(.easeInOut)
            }
        }//.overlay(fetcher.loading ? Color.gray.opacity(0.2) : Color.clear)
    }
}

@main
struct GithubWidgets: Widget {
    let kind: String = "GithubWidgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            GithubWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct GithubWidgets_Previews: PreviewProvider {
    static var previews: some View {
        GithubWidgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), contribution: []))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
