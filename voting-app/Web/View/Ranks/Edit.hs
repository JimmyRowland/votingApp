module Web.View.Ranks.Edit where
import Web.View.Prelude

data EditView = EditView { rank :: Rank }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={RanksAction}>Ranks</a></li>
                <li class="breadcrumb-item active">Edit Rank</li>
            </ol>
        </nav>
        <h1>Edit Rank</h1>
        {renderForm rank}
    |]

renderForm :: Rank -> Html
renderForm rank = formFor rank [hsx|
    {(textField #optionId)}
    {(textField #voteId)}
    {(textField #rank)}
    {submitButton}
|]
