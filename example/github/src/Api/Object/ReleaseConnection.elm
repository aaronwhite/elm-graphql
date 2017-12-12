module Api.Object.ReleaseConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReleaseConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.ReleaseEdge -> FieldDecoder (List edges) Api.Object.ReleaseConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.Release -> FieldDecoder (List nodes) Api.Object.ReleaseConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReleaseConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ReleaseConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
