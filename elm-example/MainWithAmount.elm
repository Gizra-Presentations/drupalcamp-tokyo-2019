module MainWithAmount exposing (..)

import Html exposing (Html, div, text, ul, li)
import Html.Attributes exposing (style)


main : Html a
main =
    div [ style styleWrapper ]
        [ text "Total cart: "
        , div [] [ text <| viewAmount <| getTotalCart cartWithItems ]
        , viewCart cartWithItems
        ]


type Amount
    = Amount Int


type alias Item =
    { name : String
    , amount : Amount
    , id : Int
    }


shirt : Item
shirt =
    { name = "Shirt"
    , amount = Amount 10
    , id = 1
    }


pants : Item
pants =
    { name = "Pants"
    , amount = Amount 20
    , id = 2
    }


type alias AddedItem =
    { item : Item
    , quantity : Int
    }


addedShirt : AddedItem
addedShirt =
    AddedItem shirt 1


addedPants : AddedItem
addedPants =
    { item = pants
    , quantity = 2
    }


type alias Cart =
    { addedItems : List AddedItem
    }


emptyCart : Cart
emptyCart =
    { addedItems = []
    }


cartWithItems : Cart
cartWithItems =
    { addedItems =
        [ addedShirt
        , addedPants
        ]
    }


getAmount : Item -> Int
getAmount item =
    item.id



-- getAmount : Item -> Amount
-- getAmount =
--     .amount


appendAmount : Amount -> Amount -> Amount
appendAmount (Amount firstAmount) (Amount secondAmount) =
    Amount (firstAmount + secondAmount)


multipleAmount : Int -> Amount -> Amount
multipleAmount multipleBy (Amount amount) =
    Amount (multipleBy * amount)


viewAmount : Amount -> String
viewAmount (Amount x) =
    "$" ++ toString x


getTotalCart : Cart -> Amount
getTotalCart cart =
    List.foldl
        (\addedItem accum ->
            getAmount addedItem.item
                |> multipleAmount addedItem.quantity
                |> appendAmount accum
        )
        (Amount 0)
        cart.addedItems


viewCart : Cart -> Html msg
viewCart cart =
    div [ style [ ( "margin-top", "50px" ) ] ]
        [ text "Cart contents:"
        , ul [ style [ ( "margin", "0" ) ] ]
            (List.map
                (\addedItem ->
                    li [] [ text <| addedItem.item.name ++ " (" ++ toString addedItem.quantity ++ ")" ]
                )
                cart.addedItems
            )
        ]


styleWrapper : List ( String, String )
styleWrapper =
    [ ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "align-items", "center" )
    , ( "justify-content", "center" )
    , ( "margin-top", "100px" )
    , ( "font-size", "200%" )
    ]
