//
//  NLPUtils.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 15/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//
import Foundation

struct NLPUtils {
    static func tagSentence(sentence: String, _ completion: ([String]) -> Void) {
        let tagSchemes = NSLinguisticTagger.availableTagSchemes(forLanguage: "en")
        let options: NSLinguisticTagger.Options = [NSLinguisticTagger.Options.joinNames, NSLinguisticTagger.Options.omitWhitespace]
        let linguisticTagger = NSLinguisticTagger(tagSchemes: tagSchemes, options: Int(options.rawValue))
        linguisticTagger.string = sentence
        var result: [String] = []
        linguisticTagger.enumerateTags(in: NSMakeRange(0, (sentence as NSString).length), scheme: NSLinguisticTagScheme.nameTypeOrLexicalClass, options: options) { (tag, tokenRange, _, _) in
            let token = (sentence as NSString).substring(with: tokenRange)
            let tagName: String = tag?.rawValue ?? "unknown"
            result.append("\(token) -> \(tagName)")
        }

        completion(result)
    }
}
