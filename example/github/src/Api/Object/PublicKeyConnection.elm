module Api.Object.PublicKeyConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PublicKeyConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.PublicKeyEdge -> FieldDecoder (List edges) Api.Object.PublicKeyConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.PublicKey -> FieldDecoder (List nodes) Api.Object.PublicKeyConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.PublicKeyConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.PublicKeyConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
