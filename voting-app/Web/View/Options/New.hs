module Web.View.Options.New where
import Web.View.Prelude

data NewView = NewView { option :: Option, poll:: Poll }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={OptionsAction}>Options</a></li>
                <li class="breadcrumb-item active">New Option</li>
            </ol>
        </nav>
        <h1>New Option for poll {get #name poll}</h1>
        {renderForm option}
    |]

renderForm :: Option -> Html
renderForm option = formFor option [hsx|
    {(textField #optionLabel)}
    {(hiddenField #pollId)}
    {submitButton}
|]
