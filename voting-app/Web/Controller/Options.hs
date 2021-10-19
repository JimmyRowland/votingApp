module Web.Controller.Options where

import Web.Controller.Prelude
import Web.View.Options.Index
import Web.View.Options.New
import Web.View.Options.Edit
import Web.View.Options.Show

instance Controller OptionsController where
    action OptionsAction = do
        options <- query @Option |> fetch
        render IndexView { .. }

    action NewOptionAction = do
        let option = newRecord
        render NewView { .. }

    action ShowOptionAction { optionId } = do
        option <- fetch optionId
        render ShowView { .. }

    action EditOptionAction { optionId } = do
        option <- fetch optionId
        render EditView { .. }

    action UpdateOptionAction { optionId } = do
        option <- fetch optionId
        option
            |> buildOption
            |> ifValid \case
                Left option -> render EditView { .. }
                Right option -> do
                    option <- option |> updateRecord
                    setSuccessMessage "Option updated"
                    redirectTo EditOptionAction { .. }

    action CreateOptionAction = do
        let option = newRecord @Option
        option
            |> buildOption
            |> ifValid \case
                Left option -> render NewView { .. } 
                Right option -> do
                    option <- option |> createRecord
                    setSuccessMessage "Option created"
                    redirectTo OptionsAction

    action DeleteOptionAction { optionId } = do
        option <- fetch optionId
        deleteRecord option
        setSuccessMessage "Option deleted"
        redirectTo OptionsAction

buildOption option = option
    |> fill @["optionLabel","pollId"]
