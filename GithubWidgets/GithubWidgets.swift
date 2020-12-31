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

        let currentDate = Date()
        
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

    var body: some View {
        CalendarWidget(contribution: entry.contribution)
    }
}

@main
struct GithubWidgets: Widget {
    let kind: String = "GithubWidgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            GithubWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Minimal Contribution Widget")
        .description("This widget shows the recent most calendar contributions.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct GithubWidgets_Previews: PreviewProvider {
    static var previews: some View {
        GithubWidgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), contribution: []))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
