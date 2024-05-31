// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct ScopeInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    `operator`: GraphQLNullable<GraphQLEnum<LogicalOperator>> = nil,
    filters: GraphQLNullable<[FilterInput]> = nil,
    scopes: GraphQLNullable<[ScopeInput]> = nil
  ) {
    __data = InputDict([
      "operator": `operator`,
      "filters": filters,
      "scopes": scopes
    ])
  }

  public var `operator`: GraphQLNullable<GraphQLEnum<LogicalOperator>> {
    get { __data["operator"] }
    set { __data["operator"] = newValue }
  }

  public var filters: GraphQLNullable<[FilterInput]> {
    get { __data["filters"] }
    set { __data["filters"] = newValue }
  }

  public var scopes: GraphQLNullable<[ScopeInput]> {
    get { __data["scopes"] }
    set { __data["scopes"] = newValue }
  }
}
