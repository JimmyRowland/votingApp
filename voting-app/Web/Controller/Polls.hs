module Web.Controller.Polls where

import Web.Controller.Prelude
import Web.View.Polls.Index
import Web.View.Polls.New
import Web.View.Polls.Edit
import Web.View.Polls.Show

instance Controller PollsController where
    -- Fetch all polls and render the index view
    action PollsAction = do
        polls <- query @Poll
         |> orderByDesc #createdAt 
         |> fetch
        render IndexView { .. }

    action NewPollAction = do
        let poll = newRecord
        render NewView { .. }

    action ShowPollAction { pollId } = do
        -- Fetches the poll by id and all of its options
        poll <- fetch pollId
            >>= fetchRelated #options
        
        -- Fetches the votes for the poll and all of its ranks
        votes <- query @Vote
            |> filterWhere (#pollId, pollId)
            |> fetch
            >>= collectionFetchRelated #ranks
        
        render ShowView { .. }
    
    -- Render edit poll page where user can edit name and is released flag
    action EditPollAction { pollId } = do
        poll <- fetch pollId
        render EditView { .. }

    -- Create poll document from req and update poll by id
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

    -- Create poll with name and redirect to poll index page
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

-- validate req body and apply types
buildPoll poll = poll
    |> fill @["name", "isReleased"]
    |> validateField #name nonEmpty
