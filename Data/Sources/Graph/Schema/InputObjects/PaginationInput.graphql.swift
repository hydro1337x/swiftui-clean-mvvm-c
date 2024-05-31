// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct PaginationInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    cursor: GraphQLNullable<Int> = nil,
    limit: GraphQLNullable<Int> = nil
  ) {
    __data = InputDict([
      "cursor": cursor,
      "limit": limit
    ])
  }

  public var cursor: GraphQLNullable<Int> {
    get { __data["cursor"] }
    set { __data["cursor"] = newValue }
  }

  public var limit: GraphQLNullable<Int> {
    get { __data["limit"] }
    set { __data["limit"] = newValue }
  }
}
