module Web.View.Polls.New where
import Web.View.Prelude

data NewView = NewView { poll :: Poll }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PollsAction}>Polls</a></li>
                <li class="breadcrumb-item active">New Poll</li>
            </ol>
        </nav>
        <h1>New Poll</h1>
        {renderForm poll}
    |]

renderForm :: Poll -> Html
renderForm poll = formFor poll [hsx|
    {(textField #name)}
    {submitButton}
|]
