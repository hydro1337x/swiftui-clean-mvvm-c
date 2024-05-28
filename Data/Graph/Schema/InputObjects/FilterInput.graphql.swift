// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct FilterInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    key: String,
    `operator`: GraphQLNullable<GraphQLEnum<FilterOperator>> = nil,
    value: FilterValue,
    invert: GraphQLNullable<Bool> = nil,
    allowNull: GraphQLNullable<Bool> = nil
  ) {
    __data = InputDict([
      "key": key,
      "operator": `operator`,
      "value": value,
      "invert": invert,
      "allowNull": allowNull
    ])
  }

  public var key: String {
    get { __data["key"] }
    set { __data["key"] = newValue }
  }

  public var `operator`: GraphQLNullable<GraphQLEnum<FilterOperator>> {
    get { __data["operator"] }
    set { __data["operator"] = newValue }
  }

  public var value: FilterValue {
    get { __data["value"] }
    set { __data["value"] = newValue }
  }

  public var invert: GraphQLNullable<Bool> {
    get { __data["invert"] }
    set { __data["invert"] = newValue }
  }

  public var allowNull: GraphQLNullable<Bool> {
    get { __data["allowNull"] }
    set { __data["allowNull"] = newValue }
  }
}
