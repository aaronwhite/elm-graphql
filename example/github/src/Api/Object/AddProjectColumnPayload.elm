module Api.Object.AddProjectColumnPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.AddProjectColumnPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.AddProjectColumnPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


columnEdge : Object columnEdge Api.Object.ProjectColumnEdge -> FieldDecoder columnEdge Api.Object.AddProjectColumnPayload
columnEdge object =
    Object.single "columnEdge" [] object


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.AddProjectColumnPayload
project object =
    Object.single "project" [] object
