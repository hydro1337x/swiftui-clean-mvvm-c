// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct QueryInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    scope: GraphQLNullable<ScopeInput> = nil,
    filters: GraphQLNullable<[FilterInput]> = nil,
    sort: GraphQLNullable<[SortInput]> = nil,
    pagination: GraphQLNullable<PaginationInput> = nil,
    search: GraphQLNullable<SearchInput> = nil
  ) {
    __data = InputDict([
      "scope": scope,
      "filters": filters,
      "sort": sort,
      "pagination": pagination,
      "search": search
    ])
  }

  public var scope: GraphQLNullable<ScopeInput> {
    get { __data["scope"] }
    set { __data["scope"] = newValue }
  }

  public var filters: GraphQLNullable<[FilterInput]> {
    get { __data["filters"] }
    set { __data["filters"] = newValue }
  }

  public var sort: GraphQLNullable<[SortInput]> {
    get { __data["sort"] }
    set { __data["sort"] = newValue }
  }

  public var pagination: GraphQLNullable<PaginationInput> {
    get { __data["pagination"] }
    set { __data["pagination"] = newValue }
  }

  public var search: GraphQLNullable<SearchInput> {
    get { __data["search"] }
    set { __data["search"] = newValue }
  }
}
