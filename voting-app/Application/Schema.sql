-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE polls (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);
CREATE TABLE options (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    option_label TEXT NOT NULL,
    poll_id UUID NOT NULL
);
CREATE INDEX options_poll_id_index ON options (poll_id);
CREATE TABLE votes (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    poll_id UUID NOT NULL
);
CREATE INDEX votes_poll_id_index ON votes (poll_id);
CREATE TABLE ranks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    option_id UUID NOT NULL,
    vote_id UUID NOT NULL,
    rank INT NOT NULL
);
CREATE INDEX ranks_option_id_index ON ranks (option_id);
CREATE INDEX ranks_vote_id_index ON ranks (vote_id);
ALTER TABLE options ADD CONSTRAINT options_ref_poll_id FOREIGN KEY (poll_id) REFERENCES polls (id) ON DELETE NO ACTION;
ALTER TABLE ranks ADD CONSTRAINT ranks_ref_option_id FOREIGN KEY (option_id) REFERENCES options (id) ON DELETE NO ACTION;
ALTER TABLE ranks ADD CONSTRAINT ranks_ref_vote_id FOREIGN KEY (vote_id) REFERENCES votes (id) ON DELETE NO ACTION;
ALTER TABLE votes ADD CONSTRAINT votes_ref_poll_id FOREIGN KEY (poll_id) REFERENCES polls (id) ON DELETE NO ACTION;
