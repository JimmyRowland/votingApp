module Web.View.Ranks.New where
import Web.View.Prelude

data NewView = NewView { rank :: Rank, vote:: Include "ranks" Vote, poll :: Include "options" Poll, options:: [Option] }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={RanksAction}>Ranks</a></li>
                <li class="breadcrumb-item active">New Rank</li>
            </ol>
        </nav>
        <h1>{get #name poll}</h1>
        <h2>Please select your choice {length (get #ranks vote) + 1}</h2>
        {renderForm rank options}
    |]

-- specify option id and label for ihp to generate <input type='select'/> and js

instance CanSelect Option where
    type SelectValue Option = Id Option
    selectValue = get #id
    selectLabel = get #optionLabel

renderForm :: Rank -> [Option] -> Html
renderForm rank options = formFor rank [hsx|
    {(selectField #optionId options)}
    {(hiddenField #voteId)}
    {submitButton}
|]
