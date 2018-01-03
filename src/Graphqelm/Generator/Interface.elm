module Graphqelm.Generator.Interface exposing (generate)

import Dict
import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Field as FieldGenerator
import Graphqelm.Generator.Imports as Imports
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


generate : Context -> String -> List Type.Field -> ( List String, String )
generate context name fields =
    ( Imports.interface context name
    , prepend context (Imports.interface context name) fields
        ++ fragments context (context.interfaces |> Dict.get name |> Maybe.withDefault []) (Imports.interface context name)
        ++ (List.map (FieldGenerator.generateForInterface context name) fields |> String.join "\n\n")
    )


fragments : Context -> List String -> List String -> String
fragments context implementors moduleName =
    implementors
        |> List.map (fragment context moduleName)
        |> String.join "\n\n"


fragment : Context -> List String -> String -> String
fragment context moduleName interfaceImplementor =
    interpolate
        """on{0} : SelectionSet selection {1} -> FragmentSelectionSet selection {2}
on{0} (SelectionSet fields decoder) =
    FragmentSelectionSet "{0}" fields decoder
"""
        [ interfaceImplementor, Imports.object context interfaceImplementor |> String.join ".", moduleName |> String.join "." ]


prepend : Context -> List String -> List Type.Field -> String
prepend { apiSubmodule } moduleName fields =
    interpolate """module {0} exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import {2}.Object
import {2}.Interface
import Json.Decode as Decode
import Graphqelm.Encode as Encode exposing (Value)
{1}


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) {0}
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific {0}) -> SelectionSet (a -> constructor) {0}
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor
"""
        [ moduleName |> String.join "."
        , Imports.importsString apiSubmodule moduleName fields
        , apiSubmodule |> String.join "."
        ]
