module Web.View.Ranks.New where
import Web.View.Prelude

data NewView = NewView { rank :: Rank }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={RanksAction}>Ranks</a></li>
                <li class="breadcrumb-item active">New Rank</li>
            </ol>
        </nav>
        <h1>New Rank</h1>
        {renderForm rank}
    |]

renderForm :: Rank -> Html
renderForm rank = formFor rank [hsx|
    {(textField #optionId)}
    {(textField #voteId)}
    {(textField #rank)}
    {submitButton}
|]
