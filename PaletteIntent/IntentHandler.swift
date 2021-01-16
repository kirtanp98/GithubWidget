//
//  IntentHandler.swift
//  PaletteIntent
//
//  Created by Kirtan Patel on 12/31/20.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling, NormalConfigurationIntentHandling {
    
    let fetcher = DataFetcher()
    
    func provideAccentColorOptionsCollection(for intent: NormalConfigurationIntent, with completion: @escaping (INObjectCollection<AccentColor>?, Error?) -> Void) {
        let colors = fetcher.getAccentColors()
        
        let transformedColor: [AccentColor] = colors.map { AccentColor(identifier: $0.wrappedId.uuidString, display: $0.wrappedName) }
        
        let collection = INObjectCollection(items: transformedColor)

        completion(collection, nil)
    }
    
    
    func provideColorPaletteOptionsCollection(for intent: NormalConfigurationIntent, with completion: @escaping (INObjectCollection<ColorP>?, Error?) -> Void) {
        let colors = fetcher.getColors()
        
        let transformedColor: [ColorP] = colors.map { ColorP(identifier: $0.wrappedId.uuidString, display: $0.wrappedName) }
        
        let collection = INObjectCollection(items: transformedColor)

        completion(collection, nil)
    }
    
    func provideBackgroundOptionsCollection(for intent: NormalConfigurationIntent, with completion: @escaping (INObjectCollection<BackgroundP>?, Error?) -> Void) {
            
            let backgrounds = fetcher.getBackgrounds()
            
            let transformedbackground: [BackgroundP] = backgrounds.map {
                BackgroundP(identifier: $0.wrappedID.uuidString, display: $0.wrappedName)
            }
            
            let collection = INObjectCollection(items: transformedbackground)

            completion(collection, nil)
    }
        
    func provideColorPaletteOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<ColorP>?, Error?) -> Void) {
//        let fetcher = DataFetcher()
        let colors = fetcher.getColors()
        
        let transformedColor: [ColorP] = colors.map { ColorP(identifier: $0.wrappedId.uuidString, display: $0.wrappedName) }
        
        let collection = INObjectCollection(items: transformedColor)

        completion(collection, nil)
    }
    
    func provideBackgroundOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<BackgroundP>?, Error?) -> Void) {
        
        let backgrounds = fetcher.getBackgrounds()
        
        let transformedbackground: [BackgroundP] = backgrounds.map {
            BackgroundP(identifier: $0.wrappedID.uuidString, display: $0.wrappedName)
        }
        
        let collection = INObjectCollection(items: transformedbackground)

        completion(collection, nil)
        
    }
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
