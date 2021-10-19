module Web.View.Options.Show where
import Web.View.Prelude

data ShowView = ShowView { option :: Option }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={OptionsAction}>Options</a></li>
                <li class="breadcrumb-item active">Show Option</li>
            </ol>
        </nav>
        <h1>Show Option</h1>
        <p>{option}</p>
    |]
