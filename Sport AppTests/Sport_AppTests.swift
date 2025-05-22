//
//  Sport_AppTests.swift
//  Sport AppTests
//
//  Created by Macos on 13/05/2025.
//

import XCTest
@testable import Sport_App

final class Sport_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
  
    
    func testFetchLeaguesSuccess() {
            // Given
            let mockRequester = MockNetworkRequester()
            let expectedLeague = League(
                leagueKey: 1,
                leagueName: "Premier League",
                countryKey: 44,
                countryName: "England",
                leagueLogo: nil,
                countryLogo: nil
            )
            let mockResponse = LeagueResponse(success: 1, result: [expectedLeague])
            mockRequester.mockResult = mockResponse

            let manager = NetworkManager(requester: mockRequester)
            let exp = expectation(description: "Leagues fetched")

            // When
            manager.fetchLeagues(for: Sport.football) { result in
                // Then
                switch result {
                case .success(let leagues):
                    XCTAssertEqual(leagues.count, 1)
                    XCTAssertEqual(leagues.first?.leagueName, "Premier League")
                case .failure(let error):
                    XCTFail("Expected success, got error: \(error)")
                }
                exp.fulfill()
            }

            waitForExpectations(timeout: 1)
        }

        func testFetchLeaguesFailure() {
            // Given
            let mockRequester = MockNetworkRequester()
            mockRequester.shouldFail = true
            let manager = NetworkManager(requester: mockRequester)
            let exp = expectation(description: "Leagues fetch fails")

            // When
            manager.fetchLeagues(for: Sport.football) { result in
                // Then
                switch result {
                case .success:
                    XCTFail("Expected failure, but got success")
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
                exp.fulfill()
            }

            waitForExpectations(timeout: 1)
        }
    
    func testFetchFixturesSuccess() {
        let mockRequester = MockNetworkRequester()
        
        let match = Match(
            event_key: 1,
            event_date: "2025-05-21",
            event_time: "18:00",
            event_home_team: "Team A",
            event_away_team: "Team B",
            home_team_logo: nil,
            away_team_logo: nil,
            event_final_result: nil
        )

        mockRequester.mockResult = MatchesResponse(success: 1, result: [match])

        let manager = NetworkManager(requester: mockRequester)
        let exp = expectation(description: "Fixtures success")

        manager.fetchFixtures(for: .football, leagueId: 1, from: "2025-05-20", to: "2025-05-23") { result in
            switch result {
            case .success(let matches):
                XCTAssertFalse(matches.isEmpty, "Expected matches not to be empty")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 1)
    }


        func testFetchFixturesFailure() {
            let mockRequester = MockNetworkRequester()
            mockRequester.shouldFail = true

            let manager = NetworkManager(requester: mockRequester)
            let exp = expectation(description: "Fixtures failure")

            manager.fetchFixtures(for: .football, leagueId: 1, from: "2025-05-20", to: "2025-05-23") { result in
                switch result {
                case .success:
                    XCTFail("Expected failure but got success")
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
                exp.fulfill()
            }
            waitForExpectations(timeout: 1)
        }


        // MARK: - fetchLeagueStanding

    func testFetchLeagueStandingSuccess() {
        let mockRequester = MockNetworkRequester()
        
        let standing = StandingModel(team_key: 1, standing_team: "Any Team", team_logo: nil)
        let standingsResponse = StandingsResult(
            result: Total(total: [standing])
        )
        
        mockRequester.mockResult = standingsResponse

        let manager = NetworkManager(requester: mockRequester)
        let exp = expectation(description: "Standings success")

        manager.fetchLeagueStanding(for: .football, leagueId: 1) { result in
            switch result {
            case .success(let standings):
                XCTAssertFalse(standings.isEmpty, "Expected standings not to be empty")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 1)
    }



        func testFetchLeagueStandingFailure() {
            let mockRequester = MockNetworkRequester()
            mockRequester.shouldFail = true

            let manager = NetworkManager(requester: mockRequester)
            let exp = expectation(description: "Standings failure")

            manager.fetchLeagueStanding(for: .football, leagueId: 1) { result in
                switch result {
                case .success:
                    XCTFail("Expected failure but got success")
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
                exp.fulfill()
            }
            waitForExpectations(timeout: 1)
        }


        // MARK: - fetchTeamPlayers

    func testFetchTeamPlayersSuccess() {
        let mockRequester = MockNetworkRequester()
        
        let team = TeamModel(team_name: "Team A", team_logo: nil, players: nil)
        mockRequester.mockResult = TeamResult(result: [team])

        let manager = NetworkManager(requester: mockRequester)
        let exp = expectation(description: "Team players success")

        manager.fetchTeamPlayers(for: .football, teamId: 1) { result in
            switch result {
            case .success(let teams):
                XCTAssertFalse(teams.isEmpty, "Expected teams not to be empty")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 1)
    }


        func testFetchTeamPlayersFailure() {
            let mockRequester = MockNetworkRequester()
            mockRequester.shouldFail = true

            let manager = NetworkManager(requester: mockRequester)
            let exp = expectation(description: "Team players failure")

            manager.fetchTeamPlayers(for: .football, teamId: 1) { result in
                switch result {
                case .success:
                    XCTFail("Expected failure but got success")
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
                exp.fulfill()
            }
            waitForExpectations(timeout: 1)
        }
}
