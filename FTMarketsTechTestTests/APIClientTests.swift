//
//  APIClientTests.swift
//  FTMarketsTechTestTests
//
//  Created by Simeon O'Connor on 5/28/26.
//

import Testing
@testable import FTMarketsTechTest
import Foundation

struct APIClientTests {

    @Test func send_decodesMarketQuotesResponse() async throws {
        let session = MockNetworkSession()
        session.dataToReturn = try TestJSON.data(named: "market_quotes_success")
        session.responseToReturn = makeHTTPResponse(statusCode: 200)
        let sut = makeSUT(session: session)
        let response = try await sut.send(QuotesEndpoint()) as QuotesResponseDTO
        #expect(response.data.items.count == 2)
        await #expect(response.data.items.first?.symbolInput == "FTSE:FSI")
        await #expect(response.data.items.first?.basic.name == "FTSE 100 Index")
        await #expect(response.data.items.first?.quote.lastPrice == 10495.46)
    }
    
    @Test
    func send_decodesEmptyMarketQuotesResponse() async throws {
        let session = MockNetworkSession()
        session.dataToReturn = try TestJSON.data(named: "market_quotes_empty")
        session.responseToReturn = makeHTTPResponse(statusCode: 200)
        let sut = makeSUT(session: session)
        let response = try await sut.send(QuotesEndpoint()) as QuotesResponseDTO
        await #expect(response.data.items.isEmpty)
    }

    @Test
    func send_decodesResponseWithMissingValues() async throws {
        let session = MockNetworkSession()
        session.dataToReturn = try TestJSON.data(named: "market_quotes_missing_values")
        session.responseToReturn = makeHTTPResponse(statusCode: 200)
        let sut = makeSUT(session: session)
        let response = try await sut.send(QuotesEndpoint()) as QuotesResponseDTO
        let firstItem = await response.data.items.first
        await #expect(firstItem?.symbolInput == "GBPUSD")
        await #expect(firstItem?.quote.lastPrice == nil)
        await #expect(firstItem?.quote.change1Day == nil)
        await #expect(firstItem?.quote.change1DayPercent == nil)
    }

    @Test
    func send_throwsDecodingFailedWhenResponseShapeIsInvalid() async throws {
        let session = MockNetworkSession()
        session.dataToReturn = try TestJSON.data(named: "market_quotes_invalid")
        session.responseToReturn = makeHTTPResponse(statusCode: 200)
        let sut = makeSUT(session: session)
        await #expect(throws: APIError.decodingFailed) {
            let _ = try await sut.send(QuotesEndpoint()) as QuotesResponseDTO
        }
    }

    @Test
    func send_throwsInvalidResponseWhenResponseIsNotHTTP() async {
        let session = MockNetworkSession()
        session.dataToReturn = Data()
        session.responseToReturn = URLResponse(
            url: URL(string: "https://example.com")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )

        let sut = makeSUT(session: session)

        await #expect(throws: APIError.invalidResponse) {
            let _ = try await sut.send(QuotesEndpoint()) as QuotesResponseDTO
        }
    }

    @Test
    func send_throwsServerErrorWhenStatusCodeIs400() async {
        let session = MockNetworkSession()
        session.dataToReturn = Data()
        session.responseToReturn = makeHTTPResponse(statusCode: 400)
        let sut = makeSUT(session: session)
        await #expect(throws: APIError.serverError(statusCode: 400)) {
            let _ = try await sut.send(QuotesEndpoint()) as QuotesResponseDTO
        }
    }

    @Test
    func send_throwsServerErrorWhenStatusCodeIs500() async {
        let session = MockNetworkSession()
        session.dataToReturn = Data()
        session.responseToReturn = makeHTTPResponse(statusCode: 500)
        let sut = makeSUT(session: session)
        await #expect(throws: APIError.serverError(statusCode: 500)) {
            let _ = try await sut.send(QuotesEndpoint()) as QuotesResponseDTO
        }
    }

    @Test
    func send_propagatesNetworkError() async {
        let session = MockNetworkSession()
        session.errorToThrow = URLError(.notConnectedToInternet)
        let sut = makeSUT(session: session)
        await #expect(throws: URLError.self) {
            let _ = try await sut.send(QuotesEndpoint()) as QuotesResponseDTO
        }
    }
    
    private func makeHTTPResponse(
        statusCode: Int,
        url: URL = URL(string: "https://example.com")!
    ) -> HTTPURLResponse {
        HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
    
    private func makeSUT(
        session: NetworkSession = MockNetworkSession()
    ) -> APIClient {
        APIClient(
            requestBuilder: DefaultRequestBuilder(
                baseURL: URL(string: "https://example.com")!
            ),
            session: session,
            validator: DefaultResponseValidator(),
            decoder: JSONResponseDecoder()
        )
    }

}

