module Web.Controller.Polls where

import Web.Controller.Prelude
import Web.View.Polls.Index
import Web.View.Polls.New
import Web.View.Polls.Edit
import Web.View.Polls.Show

instance Controller PollsController where
    action PollsAction = do
        polls <- query @Poll
         |> orderByDesc #createdAt 
         |> fetch
        render IndexView { .. }

    action NewPollAction = do
        let poll = newRecord
        render NewView { .. }

    action ShowPollAction { pollId } = do
        poll <- fetch pollId
            >>= fetchRelated #options
        render ShowView { .. }

    action EditPollAction { pollId } = do
        poll <- fetch pollId
        render EditView { .. }

    action UpdatePollAction { pollId } = do
        poll <- fetch pollId
        poll
            |> buildPoll
            |> ifValid \case
                Left poll -> render EditView { .. }
                Right poll -> do
                    poll <- poll |> updateRecord
                    setSuccessMessage "Poll updated"
                    redirectTo EditPollAction { .. }

    action CreatePollAction = do
        let poll = newRecord @Poll
        poll
            |> buildPoll
            |> ifValid \case
                Left poll -> render NewView { .. } 
                Right poll -> do
                    poll <- poll |> createRecord
                    setSuccessMessage "Poll created"
                    redirectTo PollsAction

    action DeletePollAction { pollId } = do
        poll <- fetch pollId
        deleteRecord poll
        setSuccessMessage "Poll deleted"
        redirectTo PollsAction

buildPoll poll = poll
    |> fill @["name", "isReleased"]
    |> validateField #name nonEmpty
