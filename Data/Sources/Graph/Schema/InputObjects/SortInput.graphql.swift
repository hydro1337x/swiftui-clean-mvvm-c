// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct SortInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    key: String,
    direction: GraphQLNullable<GraphQLEnum<SortDirection>> = nil,
    nulls: GraphQLNullable<GraphQLEnum<SortNulls>> = nil
  ) {
    __data = InputDict([
      "key": key,
      "direction": direction,
      "nulls": nulls
    ])
  }

  public var key: String {
    get { __data["key"] }
    set { __data["key"] = newValue }
  }

  public var direction: GraphQLNullable<GraphQLEnum<SortDirection>> {
    get { __data["direction"] }
    set { __data["direction"] = newValue }
  }

  public var nulls: GraphQLNullable<GraphQLEnum<SortNulls>> {
    get { __data["nulls"] }
    set { __data["nulls"] = newValue }
  }
}
