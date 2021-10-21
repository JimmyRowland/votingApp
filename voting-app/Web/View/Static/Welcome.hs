module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
           <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PollsAction}>Polls</a></li>
            </ol>
        </nav>
|]