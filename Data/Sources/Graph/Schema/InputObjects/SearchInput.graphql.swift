// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct SearchInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    term: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "term": term
    ])
  }

  public var term: GraphQLNullable<String> {
    get { __data["term"] }
    set { __data["term"] = newValue }
  }
}
