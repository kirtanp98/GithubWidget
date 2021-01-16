// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetUserContributionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getUserContributions($login: String!) {
      user(login: $login) {
        __typename
        contributionsCollection {
          __typename
          contributionCalendar {
            __typename
            colors
            totalContributions
            isHalloween
            weeks {
              __typename
              firstDay
              contributionDays {
                __typename
                color
                contributionCount
                date
                weekday
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "getUserContributions"

  public var login: String

  public init(login: String) {
    self.login = login
  }

  public var variables: GraphQLMap? {
    return ["login": login]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("user", arguments: ["login": GraphQLVariable("login")], type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    /// Lookup a user by login.
    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("contributionsCollection", type: .nonNull(.object(ContributionsCollection.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(contributionsCollection: ContributionsCollection) {
        self.init(unsafeResultMap: ["__typename": "User", "contributionsCollection": contributionsCollection.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The collection of contributions this user has made to different repositories.
      public var contributionsCollection: ContributionsCollection {
        get {
          return ContributionsCollection(unsafeResultMap: resultMap["contributionsCollection"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "contributionsCollection")
        }
      }

      public struct ContributionsCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ContributionsCollection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("contributionCalendar", type: .nonNull(.object(ContributionCalendar.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(contributionCalendar: ContributionCalendar) {
          self.init(unsafeResultMap: ["__typename": "ContributionsCollection", "contributionCalendar": contributionCalendar.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A calendar of this user's contributions on GitHub.
        public var contributionCalendar: ContributionCalendar {
          get {
            return ContributionCalendar(unsafeResultMap: resultMap["contributionCalendar"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "contributionCalendar")
          }
        }

        public struct ContributionCalendar: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ContributionCalendar"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("colors", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
              GraphQLField("totalContributions", type: .nonNull(.scalar(Int.self))),
              GraphQLField("isHalloween", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("weeks", type: .nonNull(.list(.nonNull(.object(Week.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(colors: [String], totalContributions: Int, isHalloween: Bool, weeks: [Week]) {
            self.init(unsafeResultMap: ["__typename": "ContributionCalendar", "colors": colors, "totalContributions": totalContributions, "isHalloween": isHalloween, "weeks": weeks.map { (value: Week) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of hex color codes used in this calendar. The darker the color, the more contributions it represents.
          public var colors: [String] {
            get {
              return resultMap["colors"]! as! [String]
            }
            set {
              resultMap.updateValue(newValue, forKey: "colors")
            }
          }

          /// The count of total contributions in the calendar.
          public var totalContributions: Int {
            get {
              return resultMap["totalContributions"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "totalContributions")
            }
          }

          /// Determine if the color set was chosen because it's currently Halloween.
          public var isHalloween: Bool {
            get {
              return resultMap["isHalloween"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isHalloween")
            }
          }

          /// A list of the weeks of contributions in this calendar.
          public var weeks: [Week] {
            get {
              return (resultMap["weeks"] as! [ResultMap]).map { (value: ResultMap) -> Week in Week(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Week) -> ResultMap in value.resultMap }, forKey: "weeks")
            }
          }

          public struct Week: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ContributionCalendarWeek"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("firstDay", type: .nonNull(.scalar(String.self))),
                GraphQLField("contributionDays", type: .nonNull(.list(.nonNull(.object(ContributionDay.selections))))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(firstDay: String, contributionDays: [ContributionDay]) {
              self.init(unsafeResultMap: ["__typename": "ContributionCalendarWeek", "firstDay": firstDay, "contributionDays": contributionDays.map { (value: ContributionDay) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The date of the earliest square in this week.
            public var firstDay: String {
              get {
                return resultMap["firstDay"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "firstDay")
              }
            }

            /// The days of contributions in this week.
            public var contributionDays: [ContributionDay] {
              get {
                return (resultMap["contributionDays"] as! [ResultMap]).map { (value: ResultMap) -> ContributionDay in ContributionDay(unsafeResultMap: value) }
              }
              set {
                resultMap.updateValue(newValue.map { (value: ContributionDay) -> ResultMap in value.resultMap }, forKey: "contributionDays")
              }
            }

            public struct ContributionDay: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["ContributionCalendarDay"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("color", type: .nonNull(.scalar(String.self))),
                  GraphQLField("contributionCount", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("date", type: .nonNull(.scalar(String.self))),
                  GraphQLField("weekday", type: .nonNull(.scalar(Int.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(color: String, contributionCount: Int, date: String, weekday: Int) {
                self.init(unsafeResultMap: ["__typename": "ContributionCalendarDay", "color": color, "contributionCount": contributionCount, "date": date, "weekday": weekday])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The hex color code that represents how many contributions were made on this day compared to others in the calendar.
              public var color: String {
                get {
                  return resultMap["color"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "color")
                }
              }

              /// How many contributions were made by the user on this day.
              public var contributionCount: Int {
                get {
                  return resultMap["contributionCount"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "contributionCount")
                }
              }

              /// The day this square represents.
              public var date: String {
                get {
                  return resultMap["date"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "date")
                }
              }

              /// A number representing which day of the week this square represents, e.g., 1 is Monday.
              public var weekday: Int {
                get {
                  return resultMap["weekday"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "weekday")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class GetUserInfoQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getUserInfo($login: String!) {
      user(login: $login) {
        __typename
        url
        login
        name
        avatarUrl
      }
    }
    """

  public let operationName: String = "getUserInfo"

  public var login: String

  public init(login: String) {
    self.login = login
  }

  public var variables: GraphQLMap? {
    return ["login": login]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("user", arguments: ["login": GraphQLVariable("login")], type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    /// Lookup a user by login.
    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(url: String, login: String, name: String? = nil, avatarUrl: String) {
        self.init(unsafeResultMap: ["__typename": "User", "url": url, "login": login, "name": name, "avatarUrl": avatarUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The HTTP URL for this user
      public var url: String {
        get {
          return resultMap["url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }

      /// The user's public profile name.
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: String {
        get {
          return resultMap["avatarUrl"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }
    }
  }
}

public final class GetCurrentUserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getCurrentUser {
      viewer {
        __typename
        url
        login
        name
        avatarUrl
      }
    }
    """

  public let operationName: String = "getCurrentUser"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .nonNull(.object(Viewer.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.resultMap])
    }

    /// The currently authenticated user.
    public var viewer: Viewer {
      get {
        return Viewer(unsafeResultMap: resultMap["viewer"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
          GraphQLField("login", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(url: String, login: String, name: String? = nil, avatarUrl: String) {
        self.init(unsafeResultMap: ["__typename": "User", "url": url, "login": login, "name": name, "avatarUrl": avatarUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The HTTP URL for this user
      public var url: String {
        get {
          return resultMap["url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }

      /// The username used to login.
      public var login: String {
        get {
          return resultMap["login"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "login")
        }
      }

      /// The user's public profile name.
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// A URL pointing to the user's public avatar.
      public var avatarUrl: String {
        get {
          return resultMap["avatarUrl"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
        }
      }
    }
  }
}
