//
//  TestJSON.swift
//  FTMarketsTechTestTests
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Foundation

enum TestJSON {

    static func data(
        named fileName: String,
        extension fileExtension: String = "json"
    ) throws -> Data {

        let bundle = Bundle(for: BundleFinder.self)

        guard let url = bundle.url(
            forResource: fileName,
            withExtension: fileExtension
        ) else {
            throw NSError(
                domain: "TestJSON",
                code: 1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Missing json: \(fileName).\(fileExtension)"
                ]
            )
        }

        return try Data(contentsOf: url)
    }
}

private final class BundleFinder {}
