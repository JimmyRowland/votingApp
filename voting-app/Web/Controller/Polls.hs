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
        let options = get #options poll




        
        -- Fetches the votes for the poll and all of its ranks
        votes <- query @Vote
            |> filterWhere (#pollId, pollId)
            |> fetch
            >>= collectionFetchRelated #ranks

        let winner = getWinner options votes
        
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





getWinner [] _ = "No winner"
getWinner _ [] = "No winner"
getWinner [option] _ = get #optionLabel option
getWinner options votes =
    case condorcetWinner of Nothing -> getStarWinner options votes
                            Just option -> "Condorcet winner: " ++ (get #optionLabel option)
    where condorcetWinner = find (\option -> (isCondorcetWinner option options votes)) options


isCondorcetWinner option options votes = 
    let otherOptions = filter (\otherOption -> get #id option /= get #id otherOption) options
    in foldr (\otherOption isWinner -> isWinner && (hasMoreVotes option otherOption votes)) True otherOptions


hasMoreVotes option otherOption votes 
    | diff > 0 = True
    | otherwise = False
    where diff = foldr (\vote acc -> acc + getRankDifference option otherOption (get #ranks vote)) 0 votes

getRankDifference option otherOption [] = 0
getRankDifference option otherOption ranks
    | rankDiff == 0 = 0
    | rankDiff > 0 = -1
    | otherwise = 1
    where rankDiff = (getOptionRank option ranks) - (getOptionRank otherOption ranks)

getOptionRank option ranks =
    let rankInList = filter (\rank -> get #optionId rank == get #id option) ranks
    in getRank rankInList (length ranks)

getRank [] max = max
getRank (rank:ranks) _ = get #rank rank

getStarWinner options votes =
    case starWinner of Nothing -> "No winner"
                       Just option -> "Star winner: " ++ (get #optionLabel option)
    where topTwoBordaWinner = getTopTwoBordaWinner options votes
          starWinner = find (\option -> (isCondorcetWinner option topTwoBordaWinner votes)) topTwoBordaWinner

getTopTwoBordaWinner [] _ = []
getTopTwoBordaWinner [option] _ = [option]
getTopTwoBordaWinner [option0, option1] _ = [option0, option1]
getTopTwoBordaWinner options votes =
    let optionsWithBordaCount = map (\option -> (option, getBordaCount option votes)) options
        ((option0, bordaCount0): (option1, bordaCount1): _) = sortBy (\(_, bordaCount0) (_, bordaCount1) -> compare bordaCount0 bordaCount1) optionsWithBordaCount
    in [option0, option1]

quickSortBordaCounts [] = []
quickSortBordaCounts [x] = [x]
quickSortBordaCounts ((option, bordaCount):xs) = 
    let (left, right) = partition (\(otherOption, otherBordaCount) -> otherBordaCount < bordaCount) xs
    in quickSortBordaCounts left ++ [(option, bordaCount)] ++ quickSortBordaCounts right


    

getBordaCount option votes = foldr (\vote acc -> acc + getOptionRank option (get #ranks vote)) 0 votes

