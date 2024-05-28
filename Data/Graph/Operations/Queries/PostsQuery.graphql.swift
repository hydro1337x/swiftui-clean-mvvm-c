// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class PostsQuery: GraphQLQuery {
  public static let operationName: String = "Posts"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query Posts($query: QueryInput) {
        post_query(query: $query) {
          __typename
          data {
            __typename
            id
            name
            description
            expires_at
            medias {
              __typename
              data {
                __typename
                path
                is_favourite
              }
            }
            location {
              __typename
              id
              name
              address
              medias {
                __typename
                data {
                  __typename
                  path
                  is_favourite
                }
              }
            }
            tag_assignments {
              __typename
              data {
                __typename
                tag {
                  __typename
                  name
                }
              }
            }
          }
          pagination {
            __typename
            cursor
            has_next
            total
          }
        }
      }
      """#
    ))

  public var query: GraphQLNullable<QueryInput>

  public init(query: GraphQLNullable<QueryInput>) {
    self.query = query
  }

  public var __variables: Variables? { ["query": query] }

  public struct Data: Graph.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ApolloAPI.ParentType { Graph.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("post_query", Post_query.self, arguments: ["query": .variable("query")]),
    ] }

    public var post_query: Post_query { __data["post_query"] }

    /// Post_query
    ///
    /// Parent Type: `PaginatedPostOutputType`
    public struct Post_query: Graph.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { Graph.Objects.PaginatedPostOutputType }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("data", [Datum].self),
        .field("pagination", Pagination.self),
      ] }

      public var data: [Datum] { __data["data"] }
      public var pagination: Pagination { __data["pagination"] }

      /// Post_query.Datum
      ///
      /// Parent Type: `PostOutputType`
      public struct Datum: Graph.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { Graph.Objects.PostOutputType }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("id", Graph.ID.self),
          .field("name", String.self),
          .field("description", String?.self),
          .field("expires_at", String?.self),
          .field("medias", Medias?.self),
          .field("location", Location?.self),
          .field("tag_assignments", Tag_assignments?.self),
        ] }

        public var id: Graph.ID { __data["id"] }
        public var name: String { __data["name"] }
        public var description: String? { __data["description"] }
        public var expires_at: String? { __data["expires_at"] }
        public var medias: Medias? { __data["medias"] }
        public var location: Location? { __data["location"] }
        public var tag_assignments: Tag_assignments? { __data["tag_assignments"] }

        /// Post_query.Datum.Medias
        ///
        /// Parent Type: `PaginatedMediaOutputType`
        public struct Medias: Graph.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { Graph.Objects.PaginatedMediaOutputType }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("data", [Datum].self),
          ] }

          public var data: [Datum] { __data["data"] }

          /// Post_query.Datum.Medias.Datum
          ///
          /// Parent Type: `MediaOutputType`
          public struct Datum: Graph.SelectionSet {
            public let __data: DataDict
            public init(data: DataDict) { __data = data }

            public static var __parentType: ApolloAPI.ParentType { Graph.Objects.MediaOutputType }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("path", String.self),
              .field("is_favourite", Bool.self),
            ] }

            public var path: String { __data["path"] }
            public var is_favourite: Bool { __data["is_favourite"] }
          }
        }

        /// Post_query.Datum.Location
        ///
        /// Parent Type: `LocationOutputType`
        public struct Location: Graph.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { Graph.Objects.LocationOutputType }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("id", Graph.ID.self),
            .field("name", String.self),
            .field("address", String?.self),
            .field("medias", Medias?.self),
          ] }

          public var id: Graph.ID { __data["id"] }
          public var name: String { __data["name"] }
          public var address: String? { __data["address"] }
          public var medias: Medias? { __data["medias"] }

          /// Post_query.Datum.Location.Medias
          ///
          /// Parent Type: `PaginatedMediaOutputType`
          public struct Medias: Graph.SelectionSet {
            public let __data: DataDict
            public init(data: DataDict) { __data = data }

            public static var __parentType: ApolloAPI.ParentType { Graph.Objects.PaginatedMediaOutputType }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("data", [Datum].self),
            ] }

            public var data: [Datum] { __data["data"] }

            /// Post_query.Datum.Location.Medias.Datum
            ///
            /// Parent Type: `MediaOutputType`
            public struct Datum: Graph.SelectionSet {
              public let __data: DataDict
              public init(data: DataDict) { __data = data }

              public static var __parentType: ApolloAPI.ParentType { Graph.Objects.MediaOutputType }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("path", String.self),
                .field("is_favourite", Bool.self),
              ] }

              public var path: String { __data["path"] }
              public var is_favourite: Bool { __data["is_favourite"] }
            }
          }
        }

        /// Post_query.Datum.Tag_assignments
        ///
        /// Parent Type: `PaginatedTagAssignmentOutputType`
        public struct Tag_assignments: Graph.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { Graph.Objects.PaginatedTagAssignmentOutputType }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("data", [Datum].self),
          ] }

          public var data: [Datum] { __data["data"] }

          /// Post_query.Datum.Tag_assignments.Datum
          ///
          /// Parent Type: `TagAssignmentOutputType`
          public struct Datum: Graph.SelectionSet {
            public let __data: DataDict
            public init(data: DataDict) { __data = data }

            public static var __parentType: ApolloAPI.ParentType { Graph.Objects.TagAssignmentOutputType }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("tag", Tag?.self),
            ] }

            public var tag: Tag? { __data["tag"] }

            /// Post_query.Datum.Tag_assignments.Datum.Tag
            ///
            /// Parent Type: `TagOutputType`
            public struct Tag: Graph.SelectionSet {
              public let __data: DataDict
              public init(data: DataDict) { __data = data }

              public static var __parentType: ApolloAPI.ParentType { Graph.Objects.TagOutputType }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("name", String.self),
              ] }

              public var name: String { __data["name"] }
            }
          }
        }
      }

      /// Post_query.Pagination
      ///
      /// Parent Type: `PaginationOutput`
      public struct Pagination: Graph.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { Graph.Objects.PaginationOutput }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("cursor", Int.self),
          .field("has_next", Bool.self),
          .field("total", Int.self),
        ] }

        public var cursor: Int { __data["cursor"] }
        public var has_next: Bool { __data["has_next"] }
        public var total: Int { __data["total"] }
      }
    }
  }
}
