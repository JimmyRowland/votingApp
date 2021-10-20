module Web.View.Polls.Edit where
import Web.View.Prelude

data EditView = EditView { poll :: Poll }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PollsAction}>Polls</a></li>
                <li class="breadcrumb-item active">Edit Poll</li>
            </ol>
        </nav>
        <h1>Edit Poll</h1>
        {renderForm poll}
    |]

renderForm :: Poll -> Html
renderForm poll = formFor poll [hsx|
    {(textField #name)}
    {(checkboxField #isReleased)}
    {submitButton}
|]
