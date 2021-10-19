module Web.View.Options.Edit where
import Web.View.Prelude

data EditView = EditView { option :: Option }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={OptionsAction}>Options</a></li>
                <li class="breadcrumb-item active">Edit Option</li>
            </ol>
        </nav>
        <h1>Edit Option</h1>
        {renderForm option}
    |]

renderForm :: Option -> Html
renderForm option = formFor option [hsx|
    {(textField #optionLabel)}
    {(textField #pollId)}
    {submitButton}
|]
