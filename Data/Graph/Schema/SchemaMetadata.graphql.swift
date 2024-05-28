// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == Graph.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == Graph.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == Graph.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == Graph.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Query": return Graph.Objects.Query
    case "PaginatedPostOutputType": return Graph.Objects.PaginatedPostOutputType
    case "PostOutputType": return Graph.Objects.PostOutputType
    case "PaginatedMediaOutputType": return Graph.Objects.PaginatedMediaOutputType
    case "MediaOutputType": return Graph.Objects.MediaOutputType
    case "LocationOutputType": return Graph.Objects.LocationOutputType
    case "PaginatedTagAssignmentOutputType": return Graph.Objects.PaginatedTagAssignmentOutputType
    case "TagAssignmentOutputType": return Graph.Objects.TagAssignmentOutputType
    case "TagOutputType": return Graph.Objects.TagOutputType
    case "PaginationOutput": return Graph.Objects.PaginationOutput
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
